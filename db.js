const util = require('util');
var sanitizer = require('sanitizer');
var Q = require('q');
var crypto = require('crypto');
var pg = require('pg');
var fs = require('fs');
var tokenExpirationTime = 3600000;
var PythonShell = require('python-shell');
var exec = require('child_process').exec;
var db_pw = 'serrelab';

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

function prepare_click_vectors(clicks){
    var x = [];
    var y = [];
    if (clicks != null){
        for (var idx = 0; idx < clicks.length; idx++){
            x[idx] = clicks[idx][0];
            y[idx] = clicks[idx][1];
        }
    }
    return {x:x,y:y}
}

var DbManager = function (username, password, host, port, dbName, errorCallback) {
  var self = this;
  self.errorCallback = errorCallback;
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

function do_db_query(self, query, vars, callback, params)
{
    //console.log('self=' + self);
    //console.log('self.client=' + self.client);
    self.client.query(query, vars, function(err, res) {
        if (err) { self.errorCallback(err, 'Error in query ' + query); }
        else { res.params = params; return callback(self, res, params); }
     });
}

function sample_random_image(self, current_generation, iteration_limit, callback)
{
    return do_db_query(self, 'SELECT * FROM generation_images WHERE generation=$1 AND iteration<$2 OFFSET FLOOR(RANDOM() * (SELECT COUNT(*) FROM generation_images WHERE generation=$1 AND iteration<$2)) LIMIT 1',
            [current_generation, iteration_limit], callback)
}



DbManager.prototype.locateRandomImage = function (callback) {
  var self = this;
  //console.log('Client=' + self.client);
  self.sample_callback = callback;
  do_db_query(self, 'SELECT * FROM image_count WHERE _id=1', [], locateRandomImage_counted);
}

locateRandomImage_counted = function(self, res) {
    self.global_current_generation = parseInt(res.rows[0].current_generation);
    self.iterations_per_generation = parseInt(res.rows[0].iterations_per_generation);
    sample_random_image(self, self.global_current_generation, self.iterations_per_generation, locateRandomImage_sample1);
}

locateRandomImage_sample1 = function(self, res) {
    if (res.rows.length == 0)
    {
        // Generation finished - just let people continue on a randomly selected image from this generation
        sample_random_image(self, self.global_current_generation, 999999, locateRandomImage_sample2);
        self.client.query("UPDATE image_count SET generation_finished = TRUE");
        self.client.query("NOTIFY evolve");
    }
    else
    {
        locateRandomImage_sample2(self, res)
    }
}

locateRandomImage_sample2 = function(self, res)
{
    if (res.rows.length == 0)
    {
        self.errorCallback(0, "No images in DB.");
        return [];
    }
    sample = res.rows[0];

    do_db_query(self, 'SELECT * FROM images LEFT JOIN synsets ON synsets.syn_id = images.syn_id WHERE images._id = $1', [sample.image_id], locateRandomImage_sample3)
}

locateRandomImage_sample3 = function(self, res)
{
    if (res.rows.length == 0)
    {
        self.errorCallback(0, "Inconsistent image table state. (pray to jesus.)");
        return [];
    }
    result = res.rows[0];
    var bound_data = { image_path: result.image_path, image_display_label: result.all_names, name: result.name, index_ilsvrc012: result.index_ilsvrc012 };
    //console.log('Returning bound data: ' + JSON.stringify(bound_data));
    self.sample_callback(bound_data);
};

DbManager.prototype.cnn_accuracies = function (callback) {
  var self = this;
  self.client.query('SELECT * from cnn', function(err,res){
    if (err) {
      self.errorCallback(err, 'Error looking up cnn accuracies');
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

DbManager.prototype.updateClicks = function (image_path, generation, click_path, score, username, userid, answers, callback) {
  var self = this;
  do_db_query(self, 'SELECT * FROM images WHERE image_path=$1', [image_path], updateClicks_2, { answers: answers, click_path: click_path, score:score, username:username, userid: userid, callback:callback });
}


updateClicks_2 = function(self, res) {
    // Get image ID from query
    image_id = res.rows[0]._id
    params = res.params;
    //Handle the coordinates -- need function to convert click_path into x/y vectors
    var coors = prepare_click_vectors(params.click_path);

    //Handle the responses
    var answers = params.answers;

    // Record clicks in database
    //console.log('INSERT CLICK PATHS' + [image_id, params.userid, coors, answers]);
    do_db_query(self, 'INSERT INTO click_paths (image_id, user_id, clicks, generation, result, clicktime) VALUES ($1, $2, $3, -1, $4, current_timestamp)',
            [image_id, params.userid, coors, answers], function (err, res) { /* Callback is done after score update */ });

    // Record this image as tested
    self.client.query('UPDATE generation_images SET iteration = iteration + 1 WHERE image_id=$1 AND generation=(SELECT MAX(generation) FROM generation_images WHERE image_id=$1)', [image_id],function(err,res){ });


    // Keep track of count
    self.client.query('UPDATE image_count SET clicks_in_generation = clicks_in_generation + 1',function(err,res){ });

    // Update users for highscores
    self.client.query('SELECT * FROM users WHERE cookie=$1', [params.userid], function (err, res) {
		    if (err) {
		    self.errorCallback(err, 'User table error');
        return;
      }
        if (res.rows.length > 0)
        {

            // Handing this over to the click server. Ignoring the following:
            /*
            // Update entry
            self.client.query('UPDATE users SET score=$1, name=$2 WHERE cookie=$3', [params.score, params.username, params.userid], function (err, res) {
                // Update OK?
                  if (err) {
                    self.errorCallback(err, 'User update error');
                    return;
                  }
                  //console.log('Users updated. Score = ' + params.score);
                  params.callback();
                  });
            */
        }
        else
        {
            // New user!
            self.client.query('INSERT INTO users (score, name, cookie) VALUES ($1,$2,$3)', [params.score, params.username, params.userid], function (err, res) {
                // Update OK?
                  if (err) {
                    self.errorCallback(err, 'User creation error');
                    return;
                  }
                  //console.log('User created. Score = ' + params.score);
                  params.callback();
                  });
         }
     });
};

DbManager.prototype.getScoreData = function (callback) {
  var self = this;
  self.client.query('SELECT * FROM image_count WHERE _id=1', function(err,res){
    result=res.rows[0];
    var num_images = result.num_images;
    var iterations_per_generation = result.iterations_per_generation
    var clicks_in_generation = result.clicks_in_generation
    var click_goal = num_images * iterations_per_generation;
    var clicks_to_go = Math.max(0, click_goal - clicks_in_generation);
    //console.log(JSON.stringify(result));
    // High-score table
    self.client.query('SELECT name, score, email FROM users ORDER BY score DESC LIMIT 10',function(err,res){
        if (err) {
          self.errorCallback(err, 'Error fetching highscore table');
          return;
        }
        high_scores = res.rows;
        //console.log("High scores: " + JSON.stringify(high_scores));
        var high_score = 0;
        if (high_scores.length > 0)
         {
            high_score = high_scores[0].score;
         }
        callback({'global_high_score': high_score, 'clicks_to_go': clicks_to_go, 'click_goal': click_goal, 'high_scores': high_scores});
      });
 });
};

DbManager.prototype.resetScores = function(){
  var self = this;
  var dt = new Date().getTime();
  var cmd = 'PGPASSWORD="' + db_pw + '" pg_dump -h 127.0.0.1 -U mircs -d mircs > db_dump/' + String(dt) + '.sql';
  exec(cmd, function(err, stdout, stderr) {
    if (err){
       console.log('Error dumping database');
       return;
    }
    self.client.query('UPDATE users SET score=$1',[0],function (err,res){
      if (err){
        console.log('Error resetting users');
        return;
      }
    });
  });
}

DbManager.prototype.addEmail = function (email,username,userid, callback) {
  var self = this;
  self.client.query('SELECT * FROM users WHERE cookie=$1', [userid], function (err, res) {
    if (res.rows.length == 0){
    self.client.query('INSERT INTO users (score, name, email, cookie) VALUES ($1,$2,$3,$4)', [0, username, email, userid], function (err, res) {
        // Update OK?
        if (err) {
            self.errorCallback(err, 'User update error');
            return;
        }
    });
  }else{
     self.client.query('UPDATE users SET email=$1 WHERE cookie=$2', [email, userid], function (err, res) {
        // Update OK?
        if (err) {
            self.errorCallback(err, 'User update error');
            return;
        }
    });
  }
  });
}

DbManager.prototype.getEmail = function (userid, callback) {
  var self = this;
  self.client.query('SELECT * FROM users WHERE cookie=$1', [userid], function (err, res) { 
    if (err) {
       console.log(err, 'Error getting email');
    }  
    if (typeof(res.rows[0]) == 'undefined'){
        callback({'email': ''});
    }else{
        callback({'email': res.rows[0].email});
    }
  })
}

exports.DbManager = DbManager;
