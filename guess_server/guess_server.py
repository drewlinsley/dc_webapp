#!/usr/bin/env python
# CNN server that returns model guesses on a partially revealed image
# Used by clicktionary.ai

import os, sys
from flask import Flask, request, Response, session
import numpy as np
from datetime import timedelta
import json
from guesser import load_guesser, get_image_prediction
import traceback

# Init CNN
oracle = load_guesser()

# Init Flask
app = Flask(__name__)
# @app.before_request
# def make_session_permanent():
#     session.permanent = True
#app.debug = True

@app.before_request
def func():
  session.modified = True
  app.permanent_session_lifetime = timedelta(seconds=30)


# Setup query route
@app.route('/guess', methods=['GET', 'POST', 'OPTIONS'])
def guess_path(): # #
    # Get request data
    rdata = json.loads(request.form.keys()[0])
    print 'Clicks on %s: %d' % (rdata['image_name'], len(rdata['click_array']))
    # Get true label
    true_label = oracle.db.get_label_for_image(rdata['image_name'].strip())
    print 'True label: %s' % true_label
    # Get user id
    user_id = rdata['user_id'].strip()
    print 'User ID: %s' % user_id
    # Ask the oracle
    try:
        prediction = get_image_prediction(oracle, rdata['image_name'], rdata['click_array'], rdata['user_id'], true_label,rdata['bar_value'])
    except:
        print "Exception in user code:"
        print '-'*60
        traceback.print_exc(file=sys.stdout)
        print '-'*60
        prediction = 'ERROR'
    print '...guess: %s' % prediction
    # Allow cross origin
    resp = Response(json.dumps(prediction), mimetype='application/json')#flask.jsonify(**prediction))
    h = resp.headers
    h['Access-Control-Allow-Origin'] = '*'
    h['Access-Control-Allow-Methods'] = ['GET', 'POST', 'OPTIONS']
    h['Access-Control-Max-Age'] = '21600'
    return resp

# Start flask app
app.run(host='0.0.0.0', port=7777)
