import numpy as np
import os, sys
os.environ["THEANO_FLAGS"] = "mode=FAST_RUN,device=gpu3,floatX=float32"
import psycopg2
import credentials
import json
import re
import run_cnns
from config import project_settings
from glob import glob
from scipy import misc

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

def main():
    #Get paths and settings
    p = project_settings()

    #Run program for finetuning click model and producing predicted click maps
    sys.path.append(p.model_path)
    import fine_tuning
    map_names = prepare_training_maps(p.training_map_path,p.click_box_radius)
    abs_path = os.path.dirname(os.path.abspath(__file__)) + '/'

    #Fine tuning first
    training_images = [abs_path + p.training_image_path + x for x in map_names]
    training_maps = [abs_path + p.training_map_path + x for x in map_names] 
    checkpoint_path = fine_tuning.finetune_model(p.model_path,p.nb_epoch,p.train_iters,p.val_iters,training_images,training_maps,p.model_init_training_weights,p.model_checkpoints)

    #Produce predictions
    test_images = glob(p.validation_image_path + p.im_ext)
    attention_predictions = fine_tuning.produce_maps(checkpoint_path,test_images,p.model_path + p.click_map_predictions) #Save these in the model's directory

    #run_cnns.py needs to be run to enter new accuracies into the database

if __name__ == '__main__':
    main()
