#!/usr/bin/env python

import numpy as np
import os, sys
os.environ['CUDA_VISIBLE_DEVICES'] = '0' # Run only on GPU 0 to speed up init time
import psycopg2
import credentials
import json
import re
import datetime
from data_proc_config import project_settings
from glob import glob
from scipy import misc
from db import DB

def list_combinations(la,lb):
    perms = []
    for ii in la:
        for jj in lb:
            perms.append(ii + '_' + jj)
    return perms

def update_database(cnn_name,acc,timestamp):
    if cnn_name == 'baseline_vgg16':
        db_cnn = 'sixteen_baseline_accuracy'
    elif cnn_name == 'baseline_vgg19':
        db_cnn = 'nineteen_baseline_accuracy'
    elif cnn_name == 'attention_vgg16':
        db_cnn = 'sixteen_attention_accuracy'
    elif cnn_name == 'attention_vgg19':
        db_cnn = 'nineteen_attention_accuracy'

    connection_string = credentials.python_postgresql()
    conn = psycopg2.connect(connection_string)
    cur = conn.cursor()
    if timestamp != None:
        cur.execute("INSERT INTO cnn (date) VALUES (%s)",(timestamp,))
    cur.execute("UPDATE cnn SET " + db_cnn + "=%s WHERE date=%s",(np.around(acc*100,3),timestamp))
    conn.commit()
    cur.close()
    conn.close()

def main():

    #Get paths and settings
    p = project_settings()

    #Look in directory where we expect attention maps
    attention_maps = glob(p.model_path + p.click_map_predictions + '*' + p.im_ext)

    #Create list of cnns for validating the effect of predicted click maps
    sys.path.append(p.cnn_path) #location of the below scripts
    sys.path.append(p.tf_path) #location of model prototxts
    from web_cnns import run_model
    programs = list_combinations(p.cnn_types,p.cnn_models)
    db = DB()
    test_ims = sorted(db.get_image_paths('ilsvrc2012val'))
    test_ims = [os.path.join(p.image_base_path, fn) for fn in test_ims]
    attention_maps = [os.path.join(p.model_path, fn) for fn in test_ims]

    ts = datetime.datetime.now()
    timestamp = str(ts.year) + '-' + str(ts.month) + '-' + str(ts.day)

    #Run each model
    for idx,prog in enumerate(programs):
        print 'Run model %s on %d images.' % (prog, len(test_ims))
        class_acc, t1_acc, t5_acc, t1_preds, t5_preds = \
            run_model(prog,test_ims,p.part_syn_file_path,p.full_syn_file_path,p.cnn_model_path,attention_maps)
        t1_acc = np.mean(t1_acc)
        #Add the accuracies to the database
        update_database(prog,t1_acc,timestamp)
    print('Updated CNN results')

if __name__ == '__main__':
    main()
