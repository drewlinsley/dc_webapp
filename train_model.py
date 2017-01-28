import os
import sys
import re
import argparse
import glob
import subprocess
import math
import time
import h5py
import numpy as np
from data_proc_config import project_settings
from scipy import misc
from get_clickmaps import return_image_data
from matplotlib import pyplot as plt
from matplotlib.colors import ListedColormap
from im_lists import dogs, birds, cars, plants, boats, animals, non_animals


basic_groups = {
    'dog' : dogs,
    'bird' : birds,
    'car' : cars,
    'boat' : boats,
    'plant' : plants,
    'animal' : animals,
    'non_animal' : non_animals
}


def binarize_and_store_data(name, X, h5f):
    dt = h5py.special_dtype(vlen=np.dtype('uint8'))
    X_dset = h5f.create_dataset(name, (len(X), ), dtype=dt)
    for idx, f in enumerate(X):
        X_dset[idx] = np.fromstring(open(f, 'rb').read(), dtype='uint8')


def create_dataset(labels, data, h5_path):
    h5f = h5py.File(h5_path, 'w')
    for l, d in zip(labels, data):
        binarize_and_store_data(l, d, h5f)
    h5f.close()


def customize_groups(image_category):
    return dict((k, v) for k, v in basic_groups.iteritems() if k == image_category)


def create_clickmaps(obj, im_name, num_clicks, im_size, training_map_path,\
    base_image_path, overlay_path, click_box_radius, cm, overlays,\
    convert_to_uint8=True):
    canvas = np.zeros((im_size))
    xs = np.asarray([int(np.round(float(x))) for x in obj['x']])
    ys = np.asarray([int(np.round(float(y))) for y in obj['y']])
    for idx in range(len(xs)):  # transpose clicks for js -> python
        canvas[ys[idx] - click_box_radius : ys[idx] + click_box_radius,
            xs[idx] - click_box_radius : xs[idx] + click_box_radius] = \
            canvas[ys[idx] - click_box_radius : ys[idx] + click_box_radius,
            xs[idx] - click_box_radius : xs[idx] + click_box_radius] + 1  # accumulate signal at this spot           
    if np.sum(np.abs(canvas)) == 0:
        return None 
    else:
        canvas /= np.max(canvas)
        if convert_to_uint8:
            canvas = (canvas * 255).astype('uint8')
        split_im_name = re.split('/',im_name)
        proc_im_name = split_im_name[-1]
        proc_im_type = split_im_name[0]
        misc.imsave(os.path.join(training_map_path, proc_im_name), canvas)  # Save the clickmap as an image; alternatively insert tfrecords/lmdb creation here
        if overlays:
            # Also produce an overlay if we have multiple clicks
            if proc_im_type in overlays:
                plot_overlay(os.path.join(base_image_path, im_name),
                    (canvas).astype('float'), cm, overlay_path, num_clicks=num_clicks,
                    convert_to_uint8=convert_to_uint8)
        return im_name


def plot_overlay(test_image_path, canvas, cm, prediction_overlay_path,\
    num_clicks=None, convert_to_uint8=False):
    try:
        fig, ax = plt.subplots(nrows=1, ncols=1)
        plt.imshow(misc.imread(test_image_path, flatten=True), cmap=plt.cm.gray)
        if type(canvas) is str:
            canvas = (misc.imread(canvas)).astype('float')
        canvas /= np.max(canvas)
        axis = plt.imshow(canvas, cmap=cm, vmin=0, vmax=1)
        fig.colorbar(axis)
        ax.get_xaxis().set_ticks([])
        ax.get_yaxis().set_ticks([])
        im_name = re.split('/',test_image_path)[-1]
        if num_clicks is not None:
            plt.title(im_name + ' | ' + str(num_clicks))
        else:
            plt.title(im_name)
        out_path = os.path.join(prediction_overlay_path,re.split('/',im_name)[-1])
        print 'Saving to: %s' % out_path
        plt.savefig(out_path)
    finally:
        plt.close('all')


def create_directories(dir_list):
    for d in dir_list:
        if not os.path.exists(d):
            os.makedirs(d)


def create_alpha_cmap(alpha=0.5):
    cmap = plt.cm.RdBu_r#plt.cm.Reds
    my_cmap = cmap(np.arange(cmap.N))
    my_cmap[:, -1] = np.hstack((0, np.zeros(cmap.N - 1) + alpha))
    return ListedColormap(my_cmap)


def main(generations, overlays, image_category, gpu, train_new_model):
    # Get paths and settings
    p = project_settings()
    assert p.batch_size > 0
    if image_category is None:
        image_category = p.image_category  # override the settings

    if train_new_model is None:
        train_new_model = p.train_new_model
    else:
        train_new_model = train_new_model == 'True'
        print 'Overriding training default. Setting train to: %s' %  train_new_model

    timestamp = time.localtime()
    model_name = '_'.join(image_category) if type(image_category) is list else image_category

    p.dt_string = model_name + '_' + str(timestamp.tm_mon) + '_' + str(timestamp.tm_mday) + '_' + str(timestamp.tm_hour) + '_' + str(timestamp.tm_min)
    cm = create_alpha_cmap()

    if gpu is None:
        os.environ["THEANO_FLAGS"] = "mode=FAST_RUN,device=gpu%s,lib.cnmem=0.95,floatX=float32" % (p.gpu)
    else:
        os.environ["THEANO_FLAGS"] = "mode=FAST_RUN,device=gpu%s,lib.cnmem=0.95,floatX=float32" % (gpu)

    # Create the output directories if they don't exist
    p.training_map_path = os.path.join(p.training_map_path, p.dt_string)
    p.click_overlay_path = os.path.join(p.click_overlay_path, p.dt_string)
    p.prediction_output_path = os.path.join(p.model_path, p.click_map_predictions, p.dt_string)
    p.prediction_overlay_path = os.path.join(p.model_path, p.click_map_overlays, p.dt_string)

    create_directories([p.training_map_path, p.click_overlay_path, 
        p.prediction_output_path, p.prediction_overlay_path])

    # Run program for finetuning click model and producing predicted click maps
    sys.path.append(p.model_path)
    _, consolidated_clicks, consolidated_image_info, _, _, test_images, _, clicks, total_image_info = \
        return_image_data(generations=generations)
    test_images = test_images  # [:200]  # hardcoded just to reduce our time in prediction
    overlay_names = p.image_categories_for_overlay if overlays else False  # Only look at mircs and nsf images

    # Create clickmaps
    if p.clickmap_style == 'single':
        clicks_to_use = clicks
        total_image_info = [x[0] for x in total_image_info]
        info_to_use = total_image_info
    elif p.clickmap_style == 'aggregate':
        clicks_to_use = consolidated_clicks
        info_to_use = consolidated_image_info
    map_names = [create_clickmaps(clicks_to_use[x]['clicks'], info_to_use[x][0],\
        1, p.image_size, p.training_map_path, p.image_base_path, p.click_overlay_path,\
        p.click_box_radius, cm, overlays=overlay_names) for x in range(len(clicks_to_use))]
    trim_idx = [idx for idx, x in enumerate(map_names) if x is not None]  # Remove any images with 0 clicks (skips that snuck in)
    trimmed_map_names = [map_names[x] for x in trim_idx]
    info_to_use = [info_to_use[x] for x in trim_idx]
    syn_names = [x[1] for x in info_to_use]  # this is synced with map_names

    # Figure out which images we need to look at
    if image_category == 'all':
        selected_maps = trimmed_map_names
    else:
        customized_groups = customize_groups(image_category)
        list_groups = [customized_groups[k] for k in customized_groups.iterkeys()]
        flat_groups = [item for sublist in list_groups for item in sublist]
        selected_maps = [trimmed_map_names[idx] for idx, s in enumerate(syn_names) if s in flat_groups]

    # Gather up the images
    training_images = [os.path.join(p.image_base_path, x) for x in selected_maps]
    training_maps = [os.path.join(os.path.dirname(os.path.abspath(__file__)),
        p.training_map_path, re.split('/', x)[-1]) for x in selected_maps]
    p.model_input_shape_r, p.model_input_shape_c
    out_r = int(math.ceil(p.model_input_shape_r / 8))
    out_c = int(math.ceil(p.model_input_shape_c / 8))
    import fine_tuning
    if train_new_model:
        print 'Training model on %s images + realization maps in %s' % (len(training_images), image_category)
        # Create the h5 data files
        train_h5_path = os.path.join(os.path.dirname(os.path.abspath(__file__)),
        p.training_map_path,'train_data.h5')
        train_h5_data = [training_images, training_maps]
        train_h5_labels = ['images','maps']
        val_h5_path = os.path.join(os.path.dirname(os.path.abspath(__file__)),
        p.training_map_path,'val_data.h5')
        val_h5_ims = glob.glob(os.path.join(p.image_base_path, p.validation_image_path, '*' + p.im_ext))
        val_h5_maps = [os.path.join(p.image_base_path, p.validation_map_path, re.split('/', x)[-1]) for x in val_h5_ims]  # Sync the validation maps and images
        val_h5_data = [val_h5_ims, val_h5_maps]
        val_h5_labels = ['images','maps']
        create_dataset(train_h5_labels, train_h5_data, train_h5_path)  # make our data for training
        create_dataset(val_h5_labels, val_h5_data, val_h5_path)  # also make a validation set

        val_dict = {
            'images' : val_h5_ims,
            'maps' :  val_h5_maps,
            'h5_path' : val_h5_path
        }

        # Finetune the model
        checkpoint_path = fine_tuning.finetune_model(p, out_r, out_c,
            training_images, training_maps,
            val_data=val_dict, train_h5_path=train_h5_path)
    else:
        # Using the most recent model with the use_previous model type
        most_recent_folder = max(glob.iglob(os.path.join(p.model_path,
            p.model_checkpoints, image_category + '*')), key=os.path.getctime)
        checkpoint_path = max(glob.iglob(os.path.join(most_recent_folder, '*.h5')), key=os.path.getctime)
        if p.plot_imagenet_validations:
            val_h5_ims = [os.path.join(p.image_base_path, x) for x in test_images]
        else:
            val_h5_ims = glob.glob(os.path.join(p.image_base_path, p.validation_image_path, '*' + p.im_ext))
        print 'Reusing model found in ' + checkpoint_path
    assert len(training_images) > 0

    # Produce predictions and compare them to heatmaps on the clicktionary images
    if p.plot_imagenet_validations:
        val_h5_ims = [os.path.join(p.image_base_path, x) for x in test_images]
    attention_predictions = fine_tuning.produce_maps(p, checkpoint_path, val_h5_ims)

    print 'Producing overlays for predictions'
    [plot_overlay(val_h5_ims[x], attention_predictions[x], cm,
        p.prediction_overlay_path, convert_to_uint8=True)
        for x in range(len(attention_predictions))]

    if p.transfer_images_to_g15:
        [subprocess.Popen(["scp", x,
            "clickme@g15:/home/clickme/python/dc_webapp/database_click_images/"]
            ).wait() for x in attention_predictions]
        # os.system("scp %s clickme@g15:/home/clickme/python/dc_webapp/database_click_images/%s")
    return attention_predictions


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--generations', dest='generations',
        default=None, help='Pass an integer to target a specific generation.')
    parser.add_argument('--overlays', dest='overlays',
        default=False, help='Produce overlays. Defaults to false.')
    parser.add_argument('--gpu', dest='gpu', default=False, help='GPU to use.')
    parser.add_argument('--ic', dest='image_category', type=str, default=None, help='Override the image category in the settings.')
    parser.add_argument('--tr', dest='train_new_model', default=None, help='Override the model training/testing settings to turn off (False) or on (True) training.')
    args = parser.parse_args()
    main(**vars(args))
