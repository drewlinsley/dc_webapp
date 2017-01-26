#!/usr/bin/env python
import psycopg2, sshtunnel
import psycopg2.extras
import psycopg2.extensions
import numpy as np
from credentials import postgresql_connection, g15_credentials
from copy import deepcopy

sshtunnel.DAEMON = True # Prevent hanging process due to forward thread

def start_forward():
    g15_creds = g15_credentials()
    forward =  sshtunnel.SSHTunnelForwarder('g15.clps.brown.edu',
               ssh_username=g15_creds[0],
               ssh_password=g15_creds[1],
               remote_bind_address=('127.0.0.1', 5432))
    forward.start()
    pgsql_port = forward.local_bind_port
    pgsql_string = postgresql_connection(str(pgsql_port))
    return forward, pgsql_port, pgsql_string
    
def db_connect(pgsql_port, pgsql_string):
    conn = psycopg2.connect(**pgsql_string)
    conn.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)
    cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    return conn, cur

def get_current_generation(cur):
    cur.execute("select current_generation from image_count")
    return cur.fetchone()

def get_images_in_generation(cur,current_generation):
    cur.execute("select image_id from generation_images where generation=%s", (current_generation,))
    return [x['image_id'] for x in cur.fetchall()]

def get_images_across_all_generation(cur):
    cur.execute("select image_id from generation_images")
    return [x['image_id'] for x in cur.fetchall()]

def get_images(cur):
    cur.execute("select image_id from generation_images")
    return [x[0] for x in cur.fetchall()]

def get_click_coors(cur,generations):
    if generations is None:
        cur.execute("select * from click_paths where result in ('wrong','correct')")
    else:
        cur.execute("select * from click_paths where generation=(%s) and result in ('wrong','correct')", (generations))
    return cur.fetchall()

def get_click_info(cur,image_id):
    cur.execute("select (result,user_id,clicktime) from click_paths where image_id=ANY(%s) and result in ('wrong','correct')", (image_id,))
    return cur.fetchall()

def get_image_info(cur,image_id):
    cur.execute("select (image_path,syn_id,set_name) from images where _id=ANY(%s)", (image_id,))
    return [x['row'].replace('(','').replace(')','').split(',') for x in cur.fetchall()]

def get_image_paths(cur,set_name):
    cur.execute("SELECT image_path FROM images WHERE set_name=%s", (set_name,))
    return [x['image_path'] for x in cur.fetchall()]

def filter_info(info,filters):
    idx = []
    for i,r in enumerate(info):
        if r is not None:
            if not any([r['row'][0] in f for f in filters]): idx.append(i)
    return idx

def single_or_dup(kept_image_names):
    single_entries,duplicate_entries = [],[]
    np_version = np.asarray(kept_image_names)
    for idx, item in enumerate(set(kept_image_names)):
        if kept_image_names.count(item) == 1:
            single_entries.append(idx)
        else:
            duplicate_entries.append(np.where(np_version==item)[0])
    return single_entries,duplicate_entries

def delete_key(dict, key):
    del dict[key]
    return dict

def consolidate(clicks):
    all_image_ids = np.asarray([x['image_id'] for x in clicks]) #Get all images
    unique_image_ids = np.unique(all_image_ids) #Get unique images
    consolidated_clicks = []
    num_clicks = []
    for idx in unique_image_ids: #Consolidate clicks and info for each unique image
        it_clicks = clicks[all_image_ids == idx]
        if len(it_clicks) > 1:
            keep_clicks = it_clicks[0]
            for il in range(1,len(it_clicks)):
                keep_clicks['clicks']['x'] = keep_clicks['clicks']['x'] + it_clicks[il]['clicks']['x'] #append all clicks for this image into the same list
                keep_clicks['clicks']['y'] = keep_clicks['clicks']['y'] + it_clicks[il]['clicks']['y'] 
        consolidated_clicks.append(it_clicks[0])
        num_clicks.append(len(it_clicks))
    return consolidated_clicks,num_clicks,unique_image_ids

def return_image_data(generations=None,test_set_name='ilsvrc2012val'):
    try:
        #Get data 
        forward, pgsql_port, pgsql_string = start_forward()
        conn, cur = db_connect(pgsql_port, pgsql_string)
        curr_gen = get_current_generation(cur)
        clicks = np.asarray(get_click_coors(cur,generations=generations))
        consolidated_clicks,num_clicks,unique_image_ids=consolidate(clicks)
        image_info = get_image_info(cur,unique_image_ids.tolist()) #hope this is sorted according to clicks
        total_image_info = [get_image_info(cur, [x['image_id']]) for x in clicks]
        image_types = np.unique(np.asarray([x[-1] for x in image_info]))
        test_images = get_image_paths(cur,test_set_name)
    finally:
        forward.close()
    return curr_gen,consolidated_clicks,image_info,unique_image_ids,image_types,test_images,num_clicks,clicks,total_image_info

if __name__ == '__main__':
    return_image_data(generations=None)