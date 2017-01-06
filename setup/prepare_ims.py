import os, sys, re, shutil, psycopg2, credentials
import numpy as np
from glob import glob
from scipy import misc
from synset import get_synset
from data_proc_config import project_settings

#Images
#1. 1000 random images from imagenet training set, to be reused on every clicktionary generation
#2. 9 MIRCs
#3. 4000 random images from imagenet training set, to be redrawn every clicktionary generation

#Get synsets
synset_map, all_labels = get_synset()

def mirc_syns():
    syn = {};
    syn['7'] = 'n01614925' #bald eagle
    syn['1'] = 'n02389026' #sorrel
    syn['4'] = 'n02690373'#airliner n02106166
    syn['0'] = 'n04285008'#sportscar n02106166
    syn['2'] = 'n03792782'#bike n02106166
    syn['3'] = 'n02687172'#warship n02106166
    syn['8'] = 'n02190166'#bug n02106166
    syn['5'] = 'n04356056'#glasses n02106166
    syn['6'] = 'n04350905'#suit n02106166
    skeys = syn.keys()
    return syn, skeys

def get_mirc_syns(files):
    syns = mirc_syns()[0]
    fnames = [re.split('\.',re.split('mircs',x)[-1])[0] for x in files]
    return [syns[x] for x in fnames]

def commonprefix_path(args, sep='/'):
	return os.path.commonprefix(args).rpartition(sep)[0]

def add_to_db(rel_to_path, files, set_name, syn_map=None):
    for target_path_full in files:
        target_path = os.path.relpath(target_path_full, rel_to_path)
        im_name = re.split('/', target_path)[-1]
        synset_prefix = re.split('_', im_name)[0].split('.')[0]
        if syn_map is not None:
            syn_id = syn_map[synset_prefix]
        elif synset_prefix[0] == 'n':
            syn_id = synset_prefix[0]
        else:
            syn_id = all_labels[int(synset_prefix)]
        print '    %s ID is %s' % (target_path, syn_id)
        cur.execute("INSERT INTO images (image_path, syn_id, set_name) VALUES (%s,%s,%s)",
                    (target_path, syn_id, set_name))
    n_files = len(files)
    print '%d images added for set %s.' % (n_files, set_name)
    return n_files

config = project_settings()

#Fixed directories
nsf_dir =  config.nsf_image_path #~1000 nsf images
mirc_dir = config.mirc_image_path #10 mirc images
im_dir = config.imagenet_train_path
rel_to_path = config.image_base_path

#Connect to database
connection_string = credentials.python_postgresql()
conn = psycopg2.connect(connection_string)
cur = conn.cursor()

#Grab an equal number of images from each category
num_per_category = 4
generations_per_epoch = 4
create_validation_set = False

image_count = 0

#First add in our randomly sampled images
ilsvrc2012train_images = glob(im_dir + '/*.JPEG')
image_count += add_to_db(rel_to_path, ilsvrc2012train_images, 'ilsvrc2012train')

#Now add in our fixed images
nsf_images = glob(os.path.join(nsf_dir,'*.JPEG'))
nsf_syns = [re.split('_',re.split('/',x)[-1])[0] for x in nsf_images]
image_count += add_to_db(rel_to_path, nsf_images, 'nsf')

mirc_images = glob(os.path.join(mirc_dir,'*.JPEG'))
mirc_syns = get_mirc_syns(mirc_images)
image_count += add_to_db(rel_to_path, mirc_images, 'mirc', mirc_syns)

####                
cur.execute("INSERT INTO image_count (num_images,current_generation,iteration_generation,generations_per_epoch) VALUES (%s,%s,%s,%s)",(image_count,0,0,generations_per_epoch))
cur.execute("INSERT INTO clicks (high_score) VALUES (%s)",(0,))
#cur.execute("INSERT INTO cnn (_id) VALUES (%s)",(0,))

#Finalize and close connections
conn.commit()
cur.close()
conn.close()

#Initialize CNN accuracies
print('DB is initialized. Now running CNNs.')
##If you have local GPUs
import run_cnns
run_cnns.main()
