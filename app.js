
app.get('/',function(req,res){
	res.sendFile('home.html',{'root': __dirname + '/templates'});
})

app.get('/about',function(req,res){
  res.sendFile('about.html',{'root':__dirname + '/templates'})
})

app.listen(8090,function(){
    console.log('Node server running @ http://localhost:3000')
});
