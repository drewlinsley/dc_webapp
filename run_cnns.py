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

def list_permutations(la,lb):
    perms = []
    for ii in la:
        for jj in lb:
            perms.append(ii + '_' + jj)
    return perms

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

def update_attention_db_entry(attention_predictions):
    run_cnn(attention_predictions)

def main():

    #Get paths and settings
    p = project_settings()

    #Look in directory where we expect attention maps
    attention_maps = glob(p.model_path + p.click_map_predictions + '*' + p.im_ext)

    #Create list of cnns for validating the effect of predicted click maps
    sys.path.append(cnn_path)
    programs = list_permutations(cnn_types,cnn_models)

    #run each program and update the database


if __name__ == '__main__':
    main()
