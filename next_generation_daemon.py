#!/usr/bin/env python
# Watchdog on the database to check if we accumulated enough clicks to retrain the network and resample images

import select
from dc_webapp.db import DB
from dc_webapp import run_cnns
from dc_webapp.prepare_next_generation import prepare_next_generation

class NextGenerationDaemon:
    def __init__(self):
        self.db = DB()
        self.db.cur.execute("LISTEN evolve;")

    def __del__(self):
        self.close()

    def close(self):
        self.db.close()

    def wait(self):
        if select.select([self.db.conn], [], [], 5) == ([], [], []):
            # Timeout
            print 'Still waiting...'
            return False
        else:
            # Got signal
            self.db.conn.poll()
            while self.db.conn.notifies:
                notify = self.db.conn.notifies.pop(0)
                print "Got NOTIFY:", notify.pid, notify.channel, notify.payload
            # Check if we're actually done
            self.db.cur.execute("""SELECT generation_finished FROM image_count""")
            data = self.db.cur.fetchone()
            if not len(data):
                print 'Database invalid: No generation information.'
                return False
            finished = data[0]
            print 'Finished: %s (%s)' % (finished, type(finished).__name__)
            return finished

    def run(self):
        while True:
            if self.wait():
                self.trigger()

    def trigger(self):
        # Re-train CNN
        #print "Re-training CNN"
        #run_cnns.main()
        print "Preparing next generation"
        prepare_next_generation()
        print "Daemon idle."

def run_daemon():
    daemon = NextGenerationDaemon()
    daemon.run()

if __name__ == '__main__':
    run_daemon()
