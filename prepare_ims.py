import re
import os, sys
import shutil
import psycopg2
import numpy as np
from glob import glob
from scipy import misc
from synset import get_synset
import credentials
import paramiko

def process_images(images,category_ims,mi,target_dir):
    im_name = re.split('/',images[category_ims[mi]])[-1]
    image_id = labels[int(re.split('_',im_name)[0])] #FIX THIS... WORDS ARE GETTING TRUNCATED
    target_path = target_dir + '/' + im_name
    shutil.copyfile(images[category_ims[mi]],target_path)
    return target_path,image_id 

im_dir = '/home/drew/Downloads/p2p_MIRCs/imgs/lmdb_validations'
if not os.path.isdir(im_dir):
    im_dir = '/media/data_cifs/sven2/p2p_exp'
im_dir = 'lmdb_validations'
target_dir = 'images'
validation_dir = 'validation_images'

if not os.path.exists(target_dir):
    os.makedirs(target_dir)
if not os.path.exists(validation_dir):
    os.makedirs(validation_dir)

#Get synsets
_, labels = get_synset()

#Connect to database
connection_string = credentials.python_postgresql()
conn = psycopg2.connect(connection_string)
cur = conn.cursor()

#Grab an equal number of images from each category
num_per_category = 25
num_categories = 100
generations_per_epoch = 4
clear_previous = False

images = glob(im_dir + '/*.JPEG')
im_names = np.asarray([re.split('_',re.split('/',x)[-1])[0] for x in images])

im_categories = np.unique(im_names)
selected_categories = np.copy(im_categories)
np.random.shuffle(selected_categories)
selected_categories = selected_categories[:num_categories]

# Clear previous images
if clear_previous:
    cur.execute("TRUNCATE TABLE images")
    for emptydir in [target_dir, validation_dir]:
        for fn in glob(os.path.join(emptydir, '*.JPEG')):
            os.remove(fn)

image_count = 0
for cn in range(num_categories):
    category_ims = np.where(im_names == selected_categories[cn])[0]
    np.random.shuffle(category_ims)
    for mi in range(num_per_category):
        target_path,image_id = process_images(images,category_ims,mi,target_dir)
        image_count+=1 #to ensure we are getting an accuracte count of images
        cur.execute("INSERT INTO images (image_path, syn_name, generations) VALUES (%s,%s,%s)",(target_path,image_id,0))
    #Now copy the rest of the images into the validation folder
    for mi in range(num_per_category,len(category_ims)):
        process_images(images,category_ims,mi,validation_dir)
                
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
