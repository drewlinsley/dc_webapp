#!/usr/bin/env python
# One-time setup for clicktionary
# Note: This empties the DB, i.e. it deletes any previously collected data!

from dc_webapp.setup import init_db, prepare_ims
from prepare_next_generation import prepare_next_generation
import run_cnns

# DB: Drop old tables and create new
print('Init DB...')
init_db.init_db()

# Add all training images to DB
print('Add images...')
prepare_ims.prepare_ims()

# Initialize CNN accuracies
print('Run CNNs...')
run_cnns.main()

# Start first generation
prepare_next_generation()