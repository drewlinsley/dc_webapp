import psycopg2
from dc_webapp import credentials
import os

def init_db():
    connection_string = credentials.python_postgresql()
    conn = psycopg2.connect(connection_string)
    cur = conn.cursor()
    fn = os.path.join(os.path.dirname(__file__), 'db_schema.txt')
    db_schema = open(fn).read().splitlines()
    for s in db_schema:
        t = s.strip()
        if len(t):
            cur.execute(t)
    # Finalize and close connections
    conn.commit()
    cur.close()
    conn.close()

if __name__ == '__main__':
    init_db()
