import os, sys, re, shutil, psycopg2
from dc_webapp import credentials
import numpy as np
from glob import glob
from scipy import misc
from dc_webapp.synset import get_synset, get_index2synset_map, mirc_syns
from dc_webapp.data_proc_config import project_settings

#Images
#1. 1000 random images from imagenet training set, to be reused on every clicktionary generation
#2. 9 MIRCs
#3. 4000 random images from imagenet training set, to be redrawn every clicktionary generation

def prepare_ims():
    # Get synsets
    synset_map, all_labels = get_synset()
    index2synset = get_index2synset_map()

    config = project_settings()

    # Fixed directories
    nsf_dir = config.nsf_image_path  # ~1000 nsf images
    mirc_dir = config.mirc_image_path  # 10 mirc images
    train_dir = config.imagenet_train_path
    val_dir = config.validation_image_path
    rel_to_path = config.image_base_path

    # Connect to database
    connection_string = credentials.python_postgresql()
    conn = psycopg2.connect(connection_string)
    cur = conn.cursor()

    def get_mirc_syns(files):
        return mirc_syns()[0]

    def add_to_db(rel_to_path, files, set_name, mirc_map=None, limit=None):
        if limit is not None:
            if len(files) > limit:
                files = np.random.choice(files, size=limit, replace=False)
        for target_path_full in files:
            target_path = os.path.relpath(target_path_full, rel_to_path)
            im_name = os.path.basename(target_path)
            synset_prefix = re.split('_', im_name)[0].split('.')[0]
            if mirc_map is not None:
                mirc_number = re.search('\d+', synset_prefix).group(0)
                syn_id = mirc_map[mirc_number]
            elif synset_prefix[0] == 'n':
                syn_id = synset_prefix
            else:
                syn_id = index2synset[int(synset_prefix)]
            print '    %s ID is %s' % (target_path, syn_id)
            cur.execute("INSERT INTO images (image_path, syn_id, set_name) VALUES (%s,%s,%s)",
                        (target_path, syn_id, set_name))
        n_files = len(files)
        print '%d images added for set %s.' % (n_files, set_name)
        return n_files


    image_count = 0

    #First add in our randomly sampled images
    #ilsvrc2012train_images = glob(train_dir + '/*.JPEG')
    #image_count += add_to_db(rel_to_path, ilsvrc2012train_images, 'ilsvrc2012train')

    #First add in our randomly sampled images
    #ilsvrc2012val_images = glob(val_dir + '/*.JPEG')
    #image_count += add_to_db(rel_to_path, ilsvrc2012val_images, 'ilsvrc2012val', limit=1000)

    #Now add in our fixed images
    nsf_images = glob(os.path.join(nsf_dir,'*.JPEG'))
    image_count += add_to_db(rel_to_path, nsf_images, 'nsf')

    mirc_images = glob(os.path.join(mirc_dir,'*.JPEG'))
    mirc_syn_table = get_mirc_syns(mirc_images)
    image_count += add_to_db(rel_to_path, mirc_images, 'mirc', mirc_syn_table)

    ####
    start_generation = -1
    cur.execute("INSERT INTO image_count (num_images,current_generation,iterations_per_generation,generation_finished) VALUES (%s,%s,%s,%s)",(image_count,start_generation,config.iterations_per_generation,False))
    cur.execute("INSERT INTO clicks (high_score) VALUES (%s)",(0,))
    #cur.execute("INSERT INTO cnn (_id) VALUES (%s)",(0,))

    #Finalize and close connections
    conn.commit()
    cur.close()
    conn.close()

if __name__ == '__main__':
    prepare_ims()
