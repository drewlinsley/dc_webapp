import os, sys, re, shutil, psycopg2
import psycopg2.extras
from dc_webapp import credentials
import numpy as np
from glob import glob
from scipy import misc
from dc_webapp.synset import get_synset, get_index2synset_map, mirc_syns
from dc_webapp.data_proc_config import project_settings

def prepare_next_generation():
    # Connect to database
    connection_string = credentials.python_postgresql()
    conn = psycopg2.connect(connection_string)
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("""SELECT num_images,current_generation,iterations_per_generation FROM image_count""")
    data = cur.fetchone()
    old_generation = data['current_generation']
    cur.execute("UPDATE click_paths SET generation = %s WHERE generation = -1", (old_generation, ))
    new_generation = old_generation + 1
    print 'New generation is %d' % new_generation
    image_count = 0

    def add_images_to_generation(set_name, generation, validate_category=False, limit=None):
        cur.execute("""SELECT * FROM images WHERE set_name = %s""", (set_name,))
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

    image_count += add_images_to_generation('mirc', generation=new_generation)
    image_count += add_images_to_generation('nsf', generation=new_generation, validate_category=True)
    # image_count += add_images_to_generation('random_set_1', generation=new_generation, validate_category=True)
    # image_count += add_images_to_generation('random_set_2', generation=new_generation, validate_category=True)
    image_count += add_images_to_generation('ilsvrc2012train', generation=new_generation, limit=100000)
    cur.execute("UPDATE image_count SET (num_images,current_generation,generation_finished,clicks_in_generation) = (%s,%s,%s,%s)",
                (image_count, new_generation, False, 0))
    #current_generation = cur.execute("SELECT INTO image_count (num_images,current_generation,iterations_per_generation) VALUES (%s,%s,%s)",(image_count,0,config.iterations_per_generation))
    #add_images_to_generation()
    #cur.execute("""SELECT * from images""")
    #data = cur.fetchall()

    # Finalize and close connections
    conn.commit()
    cur.close()
    conn.close()

if __name__ == '__main__':
    prepare_next_generation()

    # TODO:
    #
    #var
    #dt = new
    #Date().getTime();
    #var
    #cmd = 'PGPASSWORD="' + db_pw + '" pg_dump -h 127.0.0.1 -U mircs -d mircs > db_dump/' + String(dt) + '.sql';
    #exec (cmd, function(err, stdout, stderr)
    #{
    #if (err)
    #{
    #    console.log('Error dumping database');
    #return;
    #}
    #})
    #// PythonShell.run('train_model.py', function(pyerr)
    #{
    #    PythonShell.run('send_email.py', function(pyerr)
    #{
    #3if (pyerr)
    #console.log(pyerr);
    #console.log('finished training');
    #})
    #insert into images (image_path, syn_id, set_name) select image_path, syn_id, 'random_set_2' from images where set_name='ilsvrc2012train' ORDER BY random() limit 1000;
