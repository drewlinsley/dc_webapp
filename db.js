const util = require('util');
var sanitizer = require('sanitizer');
var Q = require('q');
var crypto = require('crypto');
var pg = require('pg');
var fs = require('fs');
var tokenExpirationTime = 3600000;
var PythonShell = require('python-shell');

function unique_ind(arr) {
    var hash = {}, result = [];
    for ( var i = 0, l = arr.length; i < l; ++i ) {
        if ( !hash.hasOwnProperty(arr[i]) ) { //it works with objects! in FF, at least
            hash[ arr[i] ] = true;
            //result.push(arr[i]);
            unique_ind[i] = i;
        }
    }
    return unique_ind;//result;
}

var DbManager = function (username, password, host, port, dbName) {
  var self = this;
  var deferred = Q.defer();
  var pgUrl = util.format("postgres://%s:%s@%s:%s/%s", username, password, host, port, dbName);
  this.client = new pg.Client(pgUrl);
  console.log('Connecting to: ', pgUrl);
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
        var bound_data = [selected_image,selected_label,selected_id];
        if ((click_goal - clicks_to_go) <= 0){// trigger training routine
          //PythonShell.run('train_model.py', function (pyerr) {
          PythonShell.run('send_email.py', function (pyerr) {
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
    var dates = []
    for (var i = 0; i < res.rows.length; i++){
      dates.push(res.rows[i].date);
    }
    ui = unique_ind(dates);
    var attention = [];
    for (var i = 0; i < ui.length; i++){
      attention.push([res.rows[ui[i]].sixteen_attention_accuracy,res.rows[ui[i]].date]);
    }
    var baseline = [res.rows[0].sixteen_baseline_accuracy,res.rows[0].date];
    var bound_data = JSON.stringify({
      baseline:baseline,
      attention:attention
    });
    callback(bound_data);
  })
}

DbManager.prototype.updateClicks = function (label, click_path, score, username, userid, answers, callback, errorCallback) {
  var self = this;
  self.client.query('SELECT * FROM images WHERE image_path=$1', [label], function (err, res) {
    if (err) {
      errorCallback(err, 'Error finding image');
      return;
    }
    var generations = parseInt(res.rows[0].generations) + 1;

    //Handle the coordinates
    var prev_coors = res.rows[0].click_path;
    if (prev_coors != null){
      prev_coors['x'].push(click_path[0]);
      prev_coors['y'].push(click_path[1]);
      coors = prev_coors; 
    }else{
      var coors = {'x':[click_path[0]],'y':[click_path[1]]};
    }

    //Handle the responses
    var prev_answers = res.rows[0].answers;
    if (prev_answers != null){
      prev_answers['answers'].push(answers[0]);
      answers = answers;
    }else{
      var coors = {'answers':[answers]};
    }

    //Update database
    self.client.query('UPDATE images SET click_path=$1, generations=$2, answers=$3 WHERE image_path=$4', [coors,generations,answers,label], function (err, res) {
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
    // Update users for highscores
    self.client.query('SELECT * FROM users WHERE cookie=$1', [userid], function (err, res) {
      if (err) {
        errorCallback(err, 'Uer table error');
        return;
      }
        if (res.rows.length > 0)
        {
            // Update entry
            self.client.query('UPDATE users SET score=$1, name=$2 WHERE cookie=$3', [score, username, userid], function (err, res) {
                // Update OK?
                  if (err) {
                    errorCallback(err, 'User update error');
                    return;
                  }
                  });
        }
        else
        {
            // New user!
            self.client.query('INSERT INTO users (score, name, cookie) VALUES ($1,$2,$3)', [score, username, userid], function (err, res) {
                // Update OK?
                  if (err) {
                    errorCallback(err, 'User creation error');
                    return;
                  }
                  });
         }
     });
  });
};

DbManager.prototype.getScoreData = function (callback, errorCallback) {
  var self = this;
  self.client.query('SELECT * FROM image_count WHERE _id=1', function(err,res){
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
      var clicks_to_go = (iteration_generation * global_num_images) + (global_num_images - num_ims_in_gen);
      self.client.query('SELECT high_score FROM clicks',function(err,res){
        if (err) {
          errorCallback(err, 'Error looking up score');
          return;
        }
        var high_score = res.rows[0].high_score;
        // High-score table
        self.client.query('SELECT name, score FROM users ORDER BY score DESC LIMIT 10',function(err,res){
            if (err) {
              errorCallback(err, 'Error fetching highscore table');
              return;
            }
            high_scores = res.rows;
            callback({'global_high_score': high_score, 'clicks_to_go': clicks_to_go, 'click_goal': click_goal, 'high_scores': high_scores});
          });
       });
     });
   });
};

DbManager.prototype.addEmail = function (email,username,userid, callback, errorCallback) {
  var self = this;
  /* Update entry
  self.client.query('UPDATE users SET email=$1 WHERE cookie=$2', [email, userid], function (err, res) {
      // Update OK?
      if (err) {
          errorCallback(err, 'User update error');
          return;
      }
  });*/
  //Add entry
  self.client.query('INSERT INTO users (score, name, email, cookie) VALUES ($1,$2,$3,$4)', [0, username, email, userid], function (err, res) {
      // Update OK?
      if (err) {
          errorCallback(err, 'User update error');
          return;
      }
  });
}

exports.DbManager = DbManager;
