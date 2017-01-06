import re, psycopg2, credentials
from synset import get_synset
from data_proc_config import project_settings

def populate_synset_table(column_name,syn_id,name,all_names,index):
    #Connect to database
    connection_string = credentials.python_postgresql()
    conn = psycopg2.connect(connection_string)
    cur = conn.cursor()
    
    #Add shit to synsets
    for si,sn,fn,idx in zip(syn_id,name,all_names,index)
        cur.execute("INSERT INTO synsets (syn_id,name,all_names,%s) VALUES (%s,%s,%s,%s)",(column_name,si,sn,fn,idx))

    #Finalize and close connections
    conn.commit()
    cur.close()
    conn.close()

#Which synset do you want to add to synsets
sm = get_synset() #ilsvrc2012; add another column to synsets for each new dataset
column_name = 'index_ilsvrc2012' #Always use index_ as the prefix

#Prepare synset for table
syn_id = sm.keys()
all_names = [x[k]['desc'] for k in sm] 
index = [x[k]['index'] for k in sm]
name = [re.split(',',x)[0] for x in all_names]
populate_synset_table(column_name=column_name,
    syn_id=syn_id,name=name,all_names=all_names,index=index)
