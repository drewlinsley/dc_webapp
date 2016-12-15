import os, sys, re, shutil, psycopg2, credentials
import numpy as np
from glob import glob
from scipy import misc
from synset import get_synset

#Images
#1. 1000 random images from imagenet training set, to be reused on every clicktionary generation
#2. 9 MIRCs
#3. 4000 random images from imagenet training set, to be redrawn every clicktionary generation

def process_images(images,category_ims,mi,target_dir):
    im_name = re.split('/',images[category_ims[mi]])[-1]
    image_id = labels[int(re.split('_',im_name)[0])] #FIX THIS... WORDS ARE GETTING TRUNCATED
    target_path = target_dir + '/' + im_name
    shutil.copyfile(images[category_ims[mi]],target_path)
    return target_path,image_id 

def mirc_syns():
    syn = {};
    syn['bald_eagle'] = 'n01614925'
    syn['sorrel'] = 'n02389026'
    syn['airliner'] = 'n02690373'#n02106166
    syn['sportscar'] = 'n04285008'#n02106166
    syn['bike'] = 'n03792782'#n02106166
    syn['warship'] = 'n02687172'#n02106166
    syn['bug'] = 'n02190166'#n02106166
    syn['glasses'] = 'n04356056'#n02106166
    syn['suit'] = 'n04350905'#n02106166
    skeys = syn.keys()
    return syn, skeys

def get_mirc_syns(files):
    syns = mirc_syns()
    fnames = [re.split('\.',x)[0] for x in files]
    return [syns[x] for x in fnames]  

def add_to_db(files,syns,image_count):
    for im, syn in enumerate(zip(files,syns):
        cur.execute("INSERT INTO images (image_path, syn_name, generations) VALUES (%s,%s,%s)",(im,syn,0))
    image_count += len(files)
    return image_count
#Fixed directories
nsf_dir = 'nsf_images' #1000 nsf images
mirc_dir = 'mirc_images' #10 mirc images

#Random sampling directories
im_dir = 'lmdb_training'
target_dir = 'images'
validation_dir = 'validation_images' #only used if create_validation_set = True (vestige)

if not os.path.exists(target_dir):
    os.makedirs(target_dir)
if not os.path.exists(validation_dir):
    os.makedirs(validation_dir)
if not os.path.exists('db_dump'):
    os.makedirs('db_dump')

#Get synsets
_, labels = get_synset()

#Connect to database
connection_string = credentials.python_postgresql()
conn = psycopg2.connect(connection_string)
cur = conn.cursor()

#Grab an equal number of images from each category
num_per_category = 4
num_categories = 1000
generations_per_epoch = 4
clear_previous = False
create_validation_set = False

images = glob(im_dir + '/*.JPEG')
im_names = np.asarray([re.split('_',re.split('/',x)[-1])[0] for x in images])

im_categories = np.unique(im_names)
selected_categories = np.copy(im_categories)
np.random.shuffle(selected_categories)
selected_categories = selected_categories[:num_categories]

# Clear previous images -- no reason to do this unless debugging
if clear_previous:
    cur.execute("TRUNCATE TABLE images")
    for emptydir in [target_dir, validation_dir]:
        for fn in glob(os.path.join(emptydir, '*.JPEG')):
            os.remove(fn)

#First add in our randomly sampled images
image_count = 0
for cn in range(num_categories):
    category_ims = np.where(im_names == selected_categories[cn])[0]
    np.random.shuffle(category_ims)
    for mi in range(num_per_category):
        target_path,image_id = process_images(images,category_ims,mi,target_dir)
        image_count+=1 #to ensure we are getting an accuracte count of images
        cur.execute("INSERT INTO images (image_path, syn_name, generations) VALUES (%s,%s,%s)",(target_path,image_id,0))
    if create_validation_set:
        #Now copy the rest of the images into the validation folder
        for mi in range(num_per_category,len(category_ims)):
            process_images(images,category_ims,mi,validation_dir)

#Now add in our fixed images
nsf_images = glob(os.path.join(nsf_dir,'*.JPEG'))
nsf_syns#UNFINISHED. WAITING ON SVEN FOR NSF IMAGE INFO.

mirc_images = glob(os.path.join(mirc_dir,'*.JPEG'))
mirc_syns = get_mirc_syns(mirc_images)
image_count = add_to_db(mirc_images,mirc_syns,image_count)

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
