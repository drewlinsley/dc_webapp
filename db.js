var sanitizer = require('sanitizer');
var Q = require('q');
var crypto = require('crypto');
var pg = require('pg');
var fs = require('fs');
var tokenExpirationTime = 3600000;


var DbManager = function (username, password, host, port, dbName) {
  var self = this;
  var deferred = Q.defer();
  var pgUrl = `postgres://${username}:${password}@${host}:${port}/${dbName}`;
  this.client = new pg.Client(pgUrl);
  this.client.connect(function (err) {
    if (err) {
      console.log('Error connecting to local sql database: ', err); // eslint-disable-line no-console
      deferred.reject(err);
    } else {
      console.log('Connected to sql database ' + dbName + ' on ' + host + ':' + port); // eslint-disable-line no-console
      deferred.resolve(self);
    }
  });
  return deferred.promise;
};

DbManager.prototype.locateRandomImage = function (callback, errorCallback) {
  var self = this;
  self.client.query('SELECT current_generation FROM image_count WHERE _id=1', function(err,res){
    var global_current_generation = res.rows[0].current_generation;
    self.client.query('SELECT * FROM images WHERE generations=$1', [global_current_generation], function (err, res) {
      if (err) {
        errorCallback(err, 'Error finding image');
        return;
      }
      var rand_selection = Math.floor((Math.random() * res.rows.length));;
      console.log(rand_selection);
      var selected_image = res.rows[rand_selection].image_path;
      var selected_label = res.rows[rand_selection].syn_name;
      var selected_id = res.rows[rand_selection]._id;
      var bound_data = [selected_image,selected_label,selected_id]
      callback(bound_data);
    });
  });
};

DbManager.prototype.updateClicks = function (label, click_path, callback, errorCallback) {
  var self = this;
  self.client.query('SELECT * FROM images WHERE image_path=$1', [label], function (err, res) {
    if (err) {
      errorCallback(err, 'Error finding image');
      return;
    }
    var generations = parseInt(res.rows[0].generations) + 1;
    var coors = {'x':click_path[0],'y':click_path[1]};
    self.client.query('UPDATE images SET click_path=$1, generations=$2 WHERE image_path=$3', [coors,generations,label], function (err, res) {
      if (err) {
        errorCallback(err, 'Error finding image');
        return;
      }
      callback();
    });
  });
};


exports.DbManager = DbManager;
