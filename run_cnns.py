import numpy as np
import os, sys
os.environ['CUDA_VISIBLE_DEVICES'] = '2' # Run only on GPU 0 to speed up init time
import psycopg2
import credentials
import json
import re
from glob import glob
from scipy import misc

def list_permutations(la,lb):
    perms = []
    for ii in la:
        for jj in lb:
            perms.append(ii + '_' + jj)
    return perms

def create_clickmaps(obj,im_name,im_size,training_map_path,click_box_radius):
    canvas = np.zeros((im_size))
    xs = np.asarray([int(np.round(float(x))) for x in obj['x']])
    ys = np.asarray([int(np.round(float(y))) for y in obj['y']])
    for idx in range(len(xs)): #transpose clicks for js -> python
        canvas[ys[idx] - click_box_radius : ys[idx] + click_box_radius,
            xs[idx] - click_box_radius : xs[idx] + click_box_radius] = \
            canvas[ys[idx] - click_box_radius : ys[idx] + click_box_radius,
            xs[idx] - click_box_radius : xs[idx] + click_box_radius] + 1             
    canvas /= np.max(canvas)
    proc_im_name = re.split('/',im_name)[-1] 
    misc.imsave(training_map_path + proc_im_name, canvas)
    return proc_im_name 

def prepare_training_maps(training_map_path,click_box_radius):
    connection_string = credentials.python_postgresql()
    conn = psycopg2.connect(connection_string)
    cur = conn.cursor()
    cur.execute("""SELECT * from images""")
    data = cur.fetchall()
    im_size = misc.imread(data[0][1]).shape[:2]
    im_names = [create_clickmaps(json.loads(x[3]),x[1],im_size,training_map_path,click_box_radius) for x in data] 
    cur.close()
    conn.close()
    return im_names

#Images for the click map prediction and folders for saving the predictions
click_box_radius = 9 
training_map_path = 'database_click_images/'
click_map_predictions = 'model_click_predictions/'
validation_image_path = 'validation_images/'
training_image_path = 'images/'
if not os.path.exists(training_map_path):
    os.makedirs(training_map_path)
if not os.path.exists(click_map_predictions):
    os.makedirs(click_map_predictions)

#For finetuning
model_path = '/home/drew/Documents/mlnet/' 
model_init_training_weights = model_path + 'models'
model_checkpoints = model_path + 'model_checkpoints'
train_iters = 10000
val_iters = 100
nb_epoch = 2

#For testing
cnn_path = '/home/drew/Documents/tensorflow-vgg/experiments/MIRC_tests/'
cnn_models = ['vgg16','vgg19']
cnn_types = ['baseline','attention']

#Run program for finetuning click model and producing predicted click maps
sys.path.append(model_path)
import fine_tuning
map_names = prepare_training_maps(training_map_path,click_box_radius)
abs_path = os.path.dirname(os.path.abspath(__file__)) + '/'

#Fine tuning first
training_images = [abs_path + training_image_path + x for x in map_names]
training_maps = [abs_path + training_map_path + x for x in map_names] 
checkpoint_path = fine_tuning.finetune_model(nb_epoch,train_iters,val_iters,training_images,training_maps,model_init_training_weights,model_checkpoints)

#Produce predictions
test_images = glob(validation_image_path + '.JPEG')
fine_tuning.produce_maps(checkpoint_path,test_images,abs_path + click_map_predictions)

#Create list of cnns for validating the effect of predicted click maps
sys.path.append(cnn_path)
programs = list_permutations(cnn_types,cnn_models)
#for pr in programs:
    
#Add cnn results to the database

