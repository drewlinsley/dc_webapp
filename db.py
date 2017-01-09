#!/usr/bin/env python
# Database class

import psycopg2
import psycopg2.extras
import psycopg2.extensions
from dc_webapp import credentials

class DB:
    def __init__(self):
        self.connection_string = credentials.python_postgresql()
        self.conn = psycopg2.connect(self.connection_string)
        self.conn.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)
        self.cur = self.conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    def __del__(self):
        # Finalize and close connections
        self.close()

    def close(self):
        self.conn.commit()
        self.cur.close()
        self.conn.close()

    def get_label_for_image(self, image_path):
        self.cur.execute("""SELECT all_names FROM images LEFT JOIN synsets ON images.syn_id = synsets.syn_id WHERE image_path = %s""", (image_path,))
        labels = self.cur.fetchall()
        if len(labels) < 1:
            return None
        return labels[0]['all_names']

if __name__ == '__main__':
    db = DB()
    print db.get_label_for_image('mircs/mircs2.JPEG')