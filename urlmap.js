var fs = require('fs');
var url = require('url');
var cron = require('cron');
var PythonShell = require('python-shell');
var s2utils = require('./s2utils.js');

/*Do I need raven?
var raven = require('raven');
var ravenClient = new raven.Client('https://020405d8e6ce4c66aca28d5fb76d486b:dd028890ac2145898c9d73bbc04dbc90@app.getsentry.com/82686');
ravenClient.patchGlobal();*/

var cronJob = cron.job("0 0 * * *", function(){
  PythonShell.run('run_cnns.py', function (err) {
    if (err) console.log(err);
    console.log('Finished updating CNN accuracy');
  });
});
cronJob.start();

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

var app_version = 1 // Reset cookie if stored under smaller app version

// Server-side user data
var getUserData = function(req) {
  sess = req.session;
  if (!sess.user_data || sess.user_data.app_version < app_version )
  {
    sess.user_data = {
        'click_count': 0,
        'score': 0,
        'name': s2utils.generateRandomName(),
        'app_version': app_version
        };
  }
  return sess.user_data;
};

exports.setupRouter = function (db, router, errorFlag) {

    router.get('/',function(req,res){
        res.sendFile('home.html',{'root': __dirname + '/templates'});
    });

    router.get('/about',function(req,res){
      res.sendFile('about.html',{'root':__dirname + '/templates'})
    });

    router.get('/cnn_accuracies',function(req,res){
      db.cnn_accuracies(function(bound_data,err){
        if (err){
          res.writeHead(400, {'Content-type':'text/html'})
          res.end('err')
        } else {
          res.end(bound_data); 
        }
      })
    });

    router.get('/random_image',function(req,res){
      db.locateRandomImage(function(bound_data){
        var random_image_path = bound_data[0];
        var random_image_label = bound_data[1];
        var id = bound_data[2];
          fs.readFile(random_image_path, {encoding: 'base64'}, function(err,content){
            if (err){
              res.writeHead(400, {'Content-type':'text/html'})
              res.end('err')
            } else {
              res.writeHead(200,{'Content-type':'image/jpg'});
              res.end(random_image_path + '!' + random_image_label + '!imagestart' + content);
            }
          });
          });
    });

    router.post('/clicks', function(req,res){
      var clicks = req.body.clicks;
      var label = req.body.image_id;
      // Count clicks server-side
      user_data = getUserData(req);
      user_data.click_count += 1;
      user_data.score += 1;
      var score = user_data.score;
      // Update click map in DB
      db.updateClicks(label,clicks,score,
        respond.bind(null, res),
        respond.bind(null, res, null));
    });

    router.get('/user_data', function(req, res) {
      // Return copy of session cookie object
      user_data = s2utils.clone(getUserData(req));
      // Add latest highscore data
      db.getScoreData(function(score_data){
        // Send it!
        user_data.scores = score_data;
        res.json(JSON.stringify(user_data));
      });
    });
}
