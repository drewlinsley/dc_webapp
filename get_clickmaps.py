#!/usr/bin/env python
import psycopg2, sshtunnel, os, collections
import psycopg2.extras
import psycopg2.extensions
import numpy as np
from credentials import postgresql_connection, g15_credentials

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

def get_images_across_all_generation(cur,current_generation):
    cur.execute("select image_id from generation_images")
    return [x['image_id'] for x in cur.fetchall()]

def get_images(cur):
    cur.execute("select image_id from generation_images")
    return [x[0] for x in cur.fetchall()]

def get_click_coors(cur,image_id):
    cur.execute("select (clicks) from click_paths where image_id=ANY(%s) and result in ('wrong','correct')", (image_id,))
    return cur.fetchall()

def get_click_info(cur,image_id):
    cur.execute("select (result,user_id,clicktime) from click_paths where image_id=ANY(%s) and result in ('wrong','correct')", (image_id,))
    return cur.fetchall()

def get_image_info(cur,image_id):
    cur.execute("select (image_path,syn_id,set_name) from images where _id=(%s)", (image_id,))
    return [x['row'].replace('(','').replace(')','').split(',') for x in cur.fetchall()]

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

def consolidate(kept_image_names,clicks,info):
    c_clicks, c_info = [], []
    single_entries,duplicate_entries = single_or_dup(kept_image_names)
    c_clicks = [clicks[x] for x in single_entries]
    c_info = [info[x] for x in single_entries]
    num_clicks = np.ones((len(single_entries)))
    for dup in duplicate_entries:
        ogc = clicks[dup[0]]
        ogi = info[dup[0]]
        for idx in range(1,len(dup)):
            for il in range(len(clicks[dup[idx]]['clicks']['x'])):
                ogc['clicks']['x'].append(clicks[dup[idx]]['clicks']['x'][il])
                ogc['clicks']['y'].append(clicks[dup[idx]]['clicks']['y'][il])    
        c_clicks.append(ogc)
        c_info.append(ogi)
        num_clicks = np.append(num_clicks,len(dup))
    return c_clicks,c_info,num_clicks

def return_image_data(generations=None):
    try:
        #Get data 
        forward, pgsql_port, pgsql_string = start_forward()
        conn, cur = db_connect(pgsql_port, pgsql_string)
        curr_gen = get_current_generation(cur)
        if generations is None:
            image_ids = get_images_in_generation(cur,curr_gen['current_generation'])
        else:
            image_ids = get_images_across_all_generation(cur,curr_gen['current_generation'])
        clicks = get_click_coors(cur,image_ids)
        click_info = get_click_info(cur,image_ids)
    
        keep_index = filter_info(click_info,['skip'])
        kept_image_ids = [image_ids[x] for x in keep_index]
        image_info = [get_image_info(cur,x)[0] for x in kept_image_ids]
        kept_image_names = [x[0] for x in image_info]
        consolidated_clicks,consolidated_info,num_clicks = consolidate(kept_image_names,clicks,image_info)
        image_types = np.unique(np.asarray([x[-1] for x in image_info]))
    finally:
        forward.close()
    return curr_gen,image_ids,consolidated_clicks,click_info,keep_index,kept_image_ids,consolidated_info,image_types,num_clicks

if __name__ == '__main__':
    return_image_data(generations=None)
