#!/usr/bin/env python
# CNN server that returns model guesses on a partially revealed image

import os
from flask import Flask, request
import numpy as np
from utils import crossdomain
import json
from guesser import load_guesser, get_image_prediction

# Init CNN
oracle = load_guesser()

# Init Flask
app = Flask(__name__)

# Setup query route
@app.route('/guess', methods=['GET', 'POST', 'OPTIONS'])
@crossdomain(origin='*')
def guess_path(): # #
    # Get request data
    rdata = json.loads(request.form.keys()[0])
    print 'Clicks on %s: %d' % (rdata['image_name'], len(rdata['click_array']))
    # Get true label
    class_index = int(os.path.basename(rdata['image_name']).split('_')[0])
    print 'True label: %s' % oracle.class_names[class_index]
    # Ask the oracle
    prediction = get_image_prediction(oracle, rdata['image_name'], rdata['click_array'])
    print '...guess: %s' % prediction
    return prediction
    #return np.random.choice(['shark', 'boob', 'explosion', 'airplane', 'dog', 'cat'])

# Start flask app
app.run(host='0.0.0.0', port=7777)
