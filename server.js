
var bodyParser = require('body-parser');
var compression = require('compression');
var cookieParser = require('cookie-parser');
var DbManager = require('./db').DbManager;
var UrlMap = require('./urlmap.js');

exports.setup = function (app, router, dbHost, dbPort, dbName, dbUser, dbPassword, errorFlag, callback) {
  app.use(cookieParser());
  app.use(bodyParser.urlencoded({limit: '70mb', extended: true, parameterLimit: 1000000}));
  app.use(bodyParser.json({limit: '70mb'}));
  app.use(compression());

  new DbManager(dbUser, dbPassword, dbHost, dbPort, dbName).then(function (db) {
    UrlMap.setupRouter(db, router, errorFlag);
    app.use('/', router);
    app.use(function (request, response) {
      // TODO send 404 http res code
      response.sendFile('/static/html/404.html', {root : __dirname});
    });
    callback(app, db);
  });
};