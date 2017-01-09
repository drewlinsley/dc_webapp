#!/usr/bin/env python
import re, psycopg2
from dc_webapp import credentials
from dc_webapp.synset import get_synset
from dc_webapp.data_proc_config import project_settings

def populate_synset_table(syn_id,name,all_names,index):
    #Connect to database
    connection_string = credentials.python_postgresql()
    conn = psycopg2.connect(connection_string)
    cur = conn.cursor()
    
    #Add shit to synsets
    for si,sn,fn,idx in zip(syn_id,name,all_names,index):
        cur.execute("INSERT INTO synsets (syn_id,name,all_names,index_ilsvrc2012) VALUES (%s,%s,%s,%s)",(si,sn,fn,idx))

    #Finalize and close connections
    conn.commit()
    cur.close()
    conn.close()

def build_synsets_table():
    #Which synset do you want to add to synsets
    sm,_ = get_synset() #ilsvrc2012; add another column to synsets for each new dataset
    #Prepare synset for table
    syn_id = sm.keys()
    all_names = [v['desc'] for v in sm.itervalues()]
    index = [v['index'] for v in sm.itervalues()]
    name = [re.split(',',x)[0] for x in all_names]
    populate_synset_table(syn_id=syn_id,name=name,all_names=all_names,index=index)

if __name__ == '__main__':
    build_synsets_table()