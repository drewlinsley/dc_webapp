var fs = require('fs');
var url = require('url');
var PythonShell = require('python-shell');
var s2utils = require('./s2utils.js');
var shortid = require('shortid');
var schedule = require('node-schedule');
//var image_root_path = '/media/data_cifs/clicktionary/webapp_data';
var image_root_path = '/media/data_clicktionary/webapp_data/'
/*var update_cnns = schedule.scheduleJob('0 0 * * *', function(){
    PythonShell.run('run_cnns.py', function (pyerr) {
        if (pyerr) console.log(pyerr);
    });
});*/

var respond = function (response, responseData, err, errorMessage) {
  if (err || errorMessage) {
    if (err) {
      if (typeof err === 'object') {
        if (err.message) {
          err = err.message;
        } else {
          err = JSON.stringify(err);
        }
      }
      err = errorMessage + ': ' + err;
    } else {
      err = errorMessage;
    }
    console.log(err); // eslint-disable-line no-console
    // return a 400 error
    response.writeHead(400, {'Content-Type': 'text/json'});
    response.write(JSON.stringify({'error' : true, 'msg' : err}));
    response.end();
    return;
  }
  if (!responseData) {
    responseData = {
      error : false
    };
  }
  response.writeHead(200, {'Content-Type': 'text/json'});
  response.write(JSON.stringify(responseData));
  response.end();
};

var app_version = 3 // Reset cookie if stored under smaller app version


var getNextDate = function() {
    var D= new Date();
    D.setMonth(D.getMonth()+1,1);
    D.setHours(0, 0, 0, 0);
    return D.getTime();
}

var getCurrentDate = function() {
    var D= new Date();
    return D.getTime();
}


// Server-side user data
var getUserData = function(req) {
  sess = req.session;
  if (!sess.user_data || sess.user_data.app_version < app_version )//|| (parseFloat(sess.user_data.expiration) - parseFloat(getCurrentDate()) < 0)) //no cookie or bad app version or expired
  {
    sess.user_data = {
        'score': 0,
        'name': s2utils.generateRandomName(),
        'userid': shortid.generate(),
        'app_version': app_version,
        'email': '',
        'expiration': getNextDate()
        };
  }
  else if (parseFloat(sess.user_data.expiration) - parseFloat(getCurrentDate()) < 0) {
        sess.user_data.score = 0;
  }
  return sess.user_data;
};

exports.setupRouter = function (db, router, errorFlag) {

    //GET
    router.get('/',function(req,res){
        res.sendFile('home.html',{'root': __dirname + '/templates'});
    });

    router.get('/about',function(req,res){
      res.sendFile('about.html',{'root':__dirname + '/templates'})
    });

    router.get('/cnn_accuracies',function(req,res){
      db.cnn_accuracies(function(bound_data){ res.end(bound_data); });
      });

    router.get('/random_image',function(req,res){
      db.locateRandomImage(function(bound_data){
        var random_image_path = bound_data.image_path;
        var random_image_full_label = bound_data.image_display_label;
        var random_image_label = bound_data.name;
        var id = bound_data[2];
          fs.readFile(image_root_path + '/' + random_image_path, {encoding: 'base64'}, function(err,content){
            if (err){
              res.writeHead(400, {'Content-type':'text/html'});
              res.end('err loading image: ' + image_root_path + '/' + random_image_path);
            } else {
              res.writeHead(200,{'Content-type':'image/jpg'});
              res.end(random_image_path + '!' + random_image_label + '!' + random_image_full_label + '!imagestart' + content);
            }
          });
        });
    });

    router.get('/user_data', function(req, res) {
      // Return copy of session cookie object
      user_data = s2utils.clone(getUserData(req));
      db.getEmail(user_data.userid,function(email){
        // Add latest highscore data
        db.getScoreData(user_data.userid, false, function(score_data){
          // Send it!
          user_data.email = email.email;
          user_data.scores = score_data;
          user_data.score = score_data.user_score;
          res.json(JSON.stringify(user_data));
        });
      });
    });

    //POST
    router.post('/clicks', function(req,res){
      var generation = req.body.generation;
      var clicks = req.body.clicks;
      var label = req.body.image_id;
      var username = req.body.username;
      var correct = req.body.correct;
      // Count clicks server-side
      var user_data = getUserData(req);
      user_data.click_count += 1;
      //if (correct == 'correct'){user_data.score += 1;}
      //else if (correct == 'top5'){user_data.score += 0.5;}
      if (correct == 'skip'){if (Math.random < 0.25){user_data.score -= 1;}}
      else if (correct == 'wrong'){}
      else{user_data.score+=parseFloat(correct);correct = 'correct';}
      var score = user_data.score;
      var username = user_data.name;
      var userid = user_data.userid; // ID to identify the user
      // Update click map in DB
      db.updateClicks(label,generation,clicks,score,username,userid,correct,
        respond.bind(null, res));
    });

    router.post('/email', function(req,res){
      var email = req.body.email;
      //if (email == null){email = 'no email recorded';}
      var user_data = getUserData(req);
      var username = user_data.name;
      var userid = user_data.userid; // ID to identify the user
      db.addEmail(email,username,userid,
        respond.bind(null, res));
    });

    /*router.get('/game_over_now', function(req,res){
        game_over_function(function(){
            res.writeHead(200, {'Content-type':'text/html'});
            res.end('Thank you for playing.');
        });
    });*/

    var game_over_function = function(callback){ //0 0 1 * *
        db.getScoreData('', true, function(score_data){
            email_list = score_data.high_scores; //Grab emails from the top 5 scores
            var pyargs = {
                args: ['--recipient','drewlinsley@gmail.com','--text',JSON.stringify(email_list)]
            };
            PythonShell.run('send_email.py', pyargs, function (pyerr) {
                if (pyerr) console.log(pyerr);
            });
            db.resetScores();
            if (callback !== null) callback();
        });
    }

    var game_over = schedule.scheduleJob('0 0 1 * *', game_over_function);
}
