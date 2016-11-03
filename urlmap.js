var fs = require('fs');
var url = require('url');
var raven = require('raven');

var ravenClient = new raven.Client('https://020405d8e6ce4c66aca28d5fb76d486b:dd028890ac2145898c9d73bbc04dbc90@app.getsentry.com/82686');
ravenClient.patchGlobal();

exports.setupRouter = function (db, router, errorFlag) {
  // non-static pages that we should not auth for
    router.get('/',function(req,res){
        res.sendFile('home.html',{'root': __dirname + '/templates'});
    })

    router.get('/about',function(req,res){
      res.sendFile('about.html',{'root':__dirname + '/templates'})
    })

    //router.listen(3000,function(){
    //    console.log('Node server running @ http://localhost:3000')
    //});

}