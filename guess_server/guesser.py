#!/usr/bin/env python
# CNN and cached image holder answering guesses

import os
os.environ['CUDA_VISIBLE_DEVICES'] = '0' # Run only on GPU 0 to speed up init time
import tensorflow as tf
import numpy as np
from dc_webapp.data_proc_config import project_settings
from tf_experiments.model_depo import vgg16
from utils import ImageCache
from dc_webapp.synset import get_synset
from dc_webapp.db import DB

def init_session():
    return tf.Session(config=tf.ConfigProto(allow_soft_placement=True, gpu_options=(tf.GPUOptions(per_process_gpu_memory_fraction=0.4))))

def load_model_vgg16(batch_size):
    # Load a default vgg16
    config = project_settings()
    image_shape = (224, 224, 3)
    weight_path = os.path.join(config.cnn_model_path, 'vgg16.npy')
    vgg = vgg16.Vgg16(vgg16_npy_path=weight_path)
    input = tf.placeholder("float", (batch_size,) + image_shape)
    with tf.name_scope("content_vgg"):
        vgg.build(input)
    # Return model and input tensor
    return vgg

def load_guesser():
    config = project_settings()
    # Init session, model and associated structures and return as one class object
    guesser = load_model_vgg16(batch_size=1)
    # Load class names
    #syn_file_contents = open(full_syn, 'rt').read().splitlines()
    #guesser.class_names = [s.split(' ')[1].split(',')[0] for s in syn_file_contents]
    guesser.class_names = [c.strip() for c in get_synset()[1]]
    # Prepare an input batch
    guesser.batch_shape = guesser.input.get_shape().as_list()
    guesser.input_batch = np.zeros(guesser.batch_shape)
    guesser.feed_dict = {guesser.input: guesser.input_batch}
    # Prepare image cache
    guesser.image_cache = ImageCache(config.image_base_path, input_size=(256, 256, 3), crop_size=guesser.batch_shape[1:3])
    guesser.session = init_session()
    guesser.db = DB()
    return guesser

def get_image_prediction(guesser, image_name, clicks, user_id, true_label, bar_value, click_size=21): # TODO: Using a larger click size for debugging
    # Return prediction index
    # Load image into batch
    image = guesser.image_cache.load_image(image_name)
    # Transfer as clicks onto empty image
    guesser.input_batch[0, ...] = np.clip(image + np.random.normal(scale=0.4, size=image.shape) - 0.5, 0.0, 1.0)
    crop_offset = guesser.image_cache.crop_margin
    for click in clicks:
        y = int(round(click[1] - crop_offset[0]))
        x = int(round(click[0] - crop_offset[1]))
        y0 = max(y - click_size // 2, 0)
        y1 = min(y + (click_size+1) // 2, guesser.batch_shape[1])
        x0 = max(x - click_size // 2, 0)
        x1 = min(x + (click_size+1) // 2, guesser.batch_shape[2])
        guesser.input_batch[0, y0:y1, x0:x1, :] = image[y0:y1, x0:x1, :]
    # Get probabilities
    prob = guesser.session.run(guesser.prob, feed_dict=guesser.feed_dict)[0].squeeze()
    # Get class index
    class_index = np.argsort(prob)[::-1]#[:5]
    pps = np.sort(prob)[::-1]#[:5]
    # Is the true label in the top 5 of class_index?
    top_5_labels = guesser.db.get_all_names_from_index(class_index[:5].tolist())
    if true_label in top_5_labels:
        #Sanitize the score
        score = (1 - float(bar_value)) * 100 #bar_value is proportion of the timer left
        if score > 100 or score < 0:
            print 'User: ' + user_id + ' may be manipulating the scoreboard. Ignoring this trial'
        else:
            #Update the user's score on the DB with the current position of the bar
            guesser.db.update_user_score(score,user_id)
        response = {
            'pp' : str(score),
            'eval' : True
        }
    else:
        response = {
            'pp' : -1,
            'eval' : False
        }
    # Debug print top prediction
    print 'Top 1: ' + str(guesser.class_names[class_index[0]]) + ' @ ' + str(pps[class_index[0]])
    # Resolve class to name
    # prediction_names = [guesser.class_names[ci] + '!' for ci in class_index]
    # pps = [str(p) + '!' for p in pps]
    return response  # prediction_names + ['@'] + pps

