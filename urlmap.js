var fs = require('fs');


var handlePublicRoutes = function (db, router) {

	router.get('/',function(req,res){
		res.sendFile('home.html',{'root': __dirname + '/templates'});
	})

	router.get('/about',function(req,res){
	  res.sendFile('about.html',{'root':__dirname + '/templates'})
	})

	router.listen(3000,function(){
	    console.log('Node server running @ http://localhost:3000')
	});
};
