
var global_image_link;
var global_label;
function getImage(ctx){
	var jqxhr = $.get('/random_image', function () {
	        })
    .done(function(data) {
      var split_data = data.split('imagestart');
      var label = split_data[0];
      var split_label = label.split('!')
      global_label = split_label[0]
      var text_label = split_label[1]
      change_title(text_label);
      global_image_link = split_data[1];
      postImage(global_image_link,ctx);
      return;
    })
}

function postImage(image_link,ctx){
	var image = new Image();
    image.src = 'data:image/jpg;base64,' + image_link;
    try{
        ctx.drawImage(image,0,0);
    }catch(err){}
    
}

function change_title(text){
    var rand_color = getRandomColor();
    $('#image_label').html('describes a <em style="color:' + rand_color + ';">' + text + '</em>')
}

function getRandomColor() {
    var letters = '0123456789ABCDEF';
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

function  getMousePos(canvas, evt) {
  var rect = canvas.getBoundingClientRect(), // abs. size of element
      scaleX = canvas.width / rect.width,    // relationship bitmap vs. element for X
      scaleY = canvas.height / rect.height;  // relationship bitmap vs. element for Y

  return {
    x: (evt.clientX - rect.left) * scaleX,   // scale mouse coordinates after they have
    y: (evt.clientY - rect.top) * scaleY     // been adjusted to be relative to element
  }
}

function draw(e) {
    postImage(global_image_link,ctx)
    var pos = getMousePos(canvas, e);
    posx = pos.x;
    posy = pos.y;
    if (posx < 0){posx = 0;}
    if (posx > 256){posx = 256;}
    if (posy < 0){posy = 0;}
    if (posy > 256){posy = 256;}
    ctx.fillStyle = 'rgba(0,0,0,0.5)';
    ctx.fillRect(posx-9, posy-9, 18, 18);
}

function clicked(e) {
    var pos = getMousePos(canvas, e);
    posx = pos.x;
    posy = pos.y;
    if (posx < 0 || posx > 256 || posy < 0 || posy > 256){}
    else{
        window.removeEventListener('mousemove', draw, false);
        postImage(global_image_link,ctx);
        ctx.fillStyle = 'rgba(0,0,0,1)';
        ctx.fillRect(posx-9, posy-9, 18, 18);
        window.removeEventListener('mousedown', clicked, false);
        upload_click_location([posx,posy]);
        setTimeout(function(){start_turn();},200);
    }
}

function upload_click_location(clicks){
    var data = {};
    data.clicks = clicks;
    data.image_id = global_label;
    $.ajax({
        type: 'POST',
        url: '/clicks',
        data: data,
        dataType: 'application/json',
        success: function(data) {
            console.log('uploaded click. update a status bar now');
        }
    });
}

function start_turn(){
    getImage(ctx);
    window.addEventListener('mousemove', draw, false);
    window.addEventListener('mousedown', clicked, false);
}

/////////
$(document).ready(function(){
    canvas = document.getElementById('myCanvas');
    ctx = canvas.getContext('2d');
    getImage(ctx);
    window.addEventListener('mousemove', draw, false);
    window.addEventListener('mousedown', clicked, false);
    start_turn()
})
