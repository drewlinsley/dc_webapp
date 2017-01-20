process.on('uncaughtException', function (error) {
  console.log(error.stack); // eslint-disable-line no-console
});

var express = require('express');
var app = express();
var pg = require('pg');
var Server = require('./server.js');
var session = require('express-session');
var PgStore = require('connect-pg-simple')(session);
var yargs = require('yargs').usage('Usage: [-p or --port=<port to run server on>]');
var request = require('request');

var argv = yargs.argv;
var port = argv.port || argv.p || 8090;
var errorFlag = argv.raven || argv.sentry || false;
var isnum = /^\d+$/.test(port);
if (!isnum) {
  console.log('Invalid port specified.'); // eslint-disable-line no-console
  return;
}
var router = express.Router();

var pgHost = 'localhost';
var pgPort = 5432;
var pgName = 'mircs';
var pgUser = 'mircs';
var pgPassword = 'serrelab';

const util = require('util');

var guess_server = 'http://localhost:7777/guess';

app.set('etag', false);

app.use('/node_modules',  express.static(__dirname + '/node_modules'));
app.use('/style',  express.static(__dirname + '/style'));
app.use('/script',  express.static(__dirname + '/script'));
app.use('/web_content', express.static(__dirname + '/web_content'));

app.post('/guess', function(req,res) {
    var x = request(guess_server);
    req.pipe(x);
    x.pipe(res);
});

// use this for storing the hashed password in the session
//app.use(require('cookie-parser'));
app.use(session({
  store: new PgStore({pg : pg, conString : util.format('postgres://%s:%s@%s:%s/%s', pgUser, pgPassword, pgHost, pgPort, pgName)}),
  secret: 'the_lab secret hash \`! _=    &&&&\`1234a56k78\'][90-=blah',
  resave: false,
  saveUninitialized: false,
  cookie: {maxAge: 24 * 60 * 60 * 1000 * 365} 
}));

Server.setup(app, router, pgHost, pgPort, pgName, pgUser, pgPassword, errorFlag, function () {
  console.log('Running server on port ' + port); // eslint-disable-line no-console
  app.listen(port);
});

process.on('uncaughtException', function (err) {
  console.log(err);
});
