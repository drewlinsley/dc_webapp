var sanitizer = require('sanitizer');
var Q = require('q');
var crypto = require('crypto');
var pg = require('pg');
var fs = require('fs');
var tokenExpirationTime = 3600000;
var PythonShell = require('python-shell');

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
  self.client.query('SELECT * FROM image_count WHERE _id=1', function(err,res){
    var global_current_generation = parseInt(res.rows[0].current_generation);
    var iteration_generation = parseInt(res.rows[0].iteration_generation);
    var generations_to_epoch = parseInt(res.rows[0].generations_per_epoch);
    var global_num_images = parseInt(res.rows[0].num_images);
    var click_goal = generations_to_epoch * global_num_images;
    self.client.query('SELECT * FROM images WHERE generations=$1', [iteration_generation], function (err, res) {
      if (err) {
        errorCallback(err, 'Error finding image');
        return;
      }
      var num_ims_in_gen = res.rows.length;
      var click_normalization = iteration_generation * (global_current_generation + 1)
      var clicks_to_go = (iteration_generation * global_num_images) + (global_num_images - num_ims_in_gen);
      var rand_selection = Math.floor((Math.random() * res.rows.length));

      var selected_image = res.rows[rand_selection].image_path;
      var selected_label = res.rows[rand_selection].syn_name;
      var selected_id = res.rows[rand_selection]._id;
      self.client.query('SELECT high_score FROM clicks',function(err,res){
        if (err) {
          errorCallback(err, 'Error looking up score');
          return;
        }
        var high_score = res.rows[0].high_score;
        var bound_data = [selected_image,selected_label,selected_id,high_score,clicks_to_go,click_goal];
        if ((click_goal - clicks_to_go) <= 0){// trigger training routine
          PythonShell.run('train_model.py', function (pyerr) {
            if (pyerr) console.log(pyerr);
            console.log('finished training');
          })
          //Iterate current_generation by generations_per_epoch here
          var new_generation = global_current_generation + generations_to_epoch
          self.client.query('UPDATE image_count SET current_generation=$1',[new_generation],function(iterr){
            if (iterr) console.log(iterr);
              console.log('Iterated current_generation by generations_to_epoch');
          })
          //And reset iteration_generation in image_count
          var new_generation = global_current_generation + generations_to_epoch
          self.client.query('UPDATE image_count SET iteration_generation=0',function(iterr){
            if (iterr) console.log(iterr);
              console.log('Reset iteration_generation in image_count');
          })
          //And reset iteration_generation in images
          var new_generation = global_current_generation + generations_to_epoch
          self.client.query('UPDATE images SET generations=0',function(iterr){
            if (iterr) console.log(iterr);
              console.log('Reset iteration_generation in images');
          })
        }
        if (num_ims_in_gen <= 1){//iterate iteration_generation
          iteration_generation += 1
          console.log((iteration_generation))
          self.client.query('UPDATE image_count SET iteration_generation=$1',[iteration_generation],function(iterr){
            if (iterr) console.log(iterr);
              console.log('Iterated iteration_generation');
          })
        }
        callback(bound_data);
      });
    });
  });
};

DbManager.prototype.cnn_accuracies = function (callback, errorCallback) {
  var self = this;
  self.client.query('SELECT * from cnn', function(err,res){
    if (err) {
      errorCallback(err, 'Error looking up cnn accuracies');
      return;
    }
    var baseline = res.rows[0].sixteen_baseline_accuracy
    var attention = res.rows[0].sixteen_attention_accuracy    
    console.log(res.rows)
    var bound_data = [baseline,attention]
    callback(bound_data);
  })
}

DbManager.prototype.updateClicks = function (label, click_path, score, callback, errorCallback) {
  var self = this;
  self.client.query('SELECT * FROM images WHERE image_path=$1', [label], function (err, res) {
    if (err) {
      errorCallback(err, 'Error finding image');
      return;
    }
    var generations = parseInt(res.rows[0].generations) + 1;
    var prev_coors = res.rows[0].click_path;
    if (prev_coors != null){
      prev_coors['x'] = [prev_coors['x'],click_path[0]];
      prev_coors['y'] = [prev_coors['y'],click_path[1]];
      coors = prev_coors; 
    }else{
      var coors = {'x':click_path[0],'y':click_path[1]};
    }
    self.client.query('UPDATE images SET click_path=$1, generations=$2 WHERE image_path=$3', [coors,generations,label], function (err, res) {
      if (err) {
        errorCallback(err, 'Error finding image');
        return;
      }
      self.client.query('SELECT high_score FROM clicks',function(err,res){
        var high_score = res.rows[0].high_score;
        if (err) {
          errorCallback(err, 'Error looking up scores');
          return;
        }
          score = parseInt(score);
          high_score = parseInt(high_score);
        if (score > high_score){
          self.client.query('UPDATE clicks SET high_score=$1 WHERE _id=1',[score],function(err,res){
            if (err) {
              errorCallback(err, 'Error setting high score');
              return;
            }
          })
        }
      })
    callback();
    });
  });
};


exports.DbManager = DbManager;
