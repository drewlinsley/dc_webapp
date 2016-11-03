import re
import os
import shutil
import psycopg2
import numpy as np
from glob import glob
from scipy import misc
from synset import get_synset
import credentials

im_dir = '/home/drew/Downloads/p2p_MIRCs/imgs/lmdb_validations'
target_dir = 'images'

if not os.path.exists(target_dir):
    os.makedirs(target_dir)

#Get synsets
_, labels = get_synset()

#Connect to database
connection_string = credentials.python_postgresql()
conn = psycopg2.connect(connection_string)
cur = conn.cursor()


#Grab an equal number of images from each category
num_per_category = 50 
num_categories = 100

images = glob(im_dir + '/*.JPEG')
im_names = np.asarray([re.split('_',re.split('/',x)[-1])[0] for x in images])

im_categories = np.unique(im_names)
selected_categories = np.copy(im_categories)
np.random.shuffle(selected_categories)
selected_categories = selected_categories[:num_categories]

image_count = 0
for cn in range(num_categories):
	category_ims = np.where(im_names == selected_categories[cn])[0]
	np.random.shuffle(category_ims)
	for mi in range(num_per_category):
		im_name = re.split('/',images[category_ims[mi]])[-1]
		image_id = labels[int(re.split('_',im_name)[0])] #FIX THIS... WORDS ARE GETTING TRUNCATED
		target_path = target_dir + '/' + im_name
		shutil.copyfile(images[category_ims[mi]],target_path)
		image_count+=1 #to ensure we are getting an accuracte count of images
		cur.execute("INSERT INTO images (image_path, syn_name, generations) VALUES (%s,%s,%s)",(target_path,image_id,0))
cur.execute("INSERT INTO image_count (num_images,current_generation) VALUES (%s,%s)",(image_count,0))

#Finalize and close connections
conn.commit()
cur.close()
conn.close()
