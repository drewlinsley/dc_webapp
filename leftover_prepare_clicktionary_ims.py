import os, sys, re, shutil, psycopg2
from dc_webapp import credentials
import numpy as np
from glob import glob
from scipy import misc
from dc_webapp.synset import get_synset, get_index2synset_map, clicktionary_syns
from dc_webapp.data_proc_config import project_settings
from psycopg2 import extras

def get_clicktionary_syns(files):
    return clicktionary_syns()[0]

def prepare_clicktionary_generation():
    # Get synsets
    synset_map, all_labels = get_synset()
    index2synset = get_index2synset_map()

    config = project_settings()

    # Fixed directories
    clicktionary_dir = config.clicktionary_dir
    rel_to_path = config.image_base_path

    # Connect to database
    connection_string = credentials.python_postgresql()
    conn = psycopg2.connect(connection_string)
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("""SELECT num_images,current_generation,iterations_per_generation FROM image_count""")
    data = cur.fetchone()
    if data is None:
        old_generation = 10000
    else:
        old_generation = data['current_generation']
    cur.execute("UPDATE click_paths SET generation = %s WHERE generation = -1", (old_generation, ))
    new_generation = old_generation + 1
    print 'New generation is %d' % new_generation
    image_count = 0

    def add_images_to_generation(set_name, generation, validate_category=False, limit=None):
        # cur.execute("""SELECT * FROM images WHERE set_name = %s""", (set_name,))
        # cur.execute("""SELECT * FROM images WHERE _id in (1293183, 1293198, 1293221, 1293224, 1293230, 1293255, 1293260, 1293263, 1293267, 1293270, 1293276, 1293287, 1293289, 1293291, 1293295, 1293304, 1293307, 1293313, 1293314, 1293315, 1293330, 1293336, 1293351, 1293353, 1293355, 1293356)""")
        cur.execute("""SELECT * FROM images WHERE _id in (1293192, 1293340, 1293338, 1293339, 1293251, 1293282, 1293271, 1293247)""")

        images = cur.fetchall()
        image_ids = [i['_id'] for i in images]
        n = 0
        if limit is not None:
            n_all = len(image_ids)
            print image_ids
            if n_all > limit:
                image_ids = np.random.choice(image_ids, size=limit, replace=False)
        for image_id in image_ids:
            cur.execute("INSERT INTO generation_images (image_id, generation, iteration) VALUES (%s,%s,%s)", (image_id, generation, 0))
        return len(image_ids)

    for idx in range(2000):
        image_count += add_images_to_generation('clicktionary', generation=new_generation)
    cur.execute("UPDATE image_count SET (num_images,current_generation,generation_finished,clicks_in_generation) = (%s,%s,%s,%s)",
                (image_count, new_generation, False, 0))
    conn.commit()
    cur.close()
    conn.close()


if __name__ == '__main__':
    prepare_clicktionary_generation()

