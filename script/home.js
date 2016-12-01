var global_image_link; //globals :(. Should rethink this at some point.
var global_label, im_text;
var global_color = "#ffffff";
var user_data = { };
var previous_loc = 0;//[0,0];
var cnn_server = '/guess';
var click_array = [];
var reveal_size = 8;
var half_size = Math.round(reveal_size/2);
var reveal_rate = 50;
var playing_image = false;
var clicks_till_update = 10; //Clicks between server calls
var time_limit = 10000;
var answer_status_timer = 500;
var posx, posy, true_posx, true_posy, global_guess, global_width, global_height;

//Background
var colors = new Array(
  [62,35,255],
  [60,255,60],
  [255,35,98],
  [45,175,230],
  [255,0,255],
  [255,128,0]);

var step = 0;
//color table indices for: 
// current color left
// next color left
// current color right
// next color right
var colorIndices = [0,1,2,3];

//transition speed
var gradientSpeed = 0.02;

function updateGradient()
{
  
  if ( $===undefined ) return;
  
var c0_0 = colors[colorIndices[0]];
var c0_1 = colors[colorIndices[1]];
var c1_0 = colors[colorIndices[2]];
var c1_1 = colors[colorIndices[3]];

var istep = 1 - step;
var r1 = Math.round(istep * c0_0[0] + step * c0_1[0]);
var g1 = Math.round(istep * c0_0[1] + step * c0_1[1]);
var b1 = Math.round(istep * c0_0[2] + step * c0_1[2]);
var color1 = "rgb("+r1+","+g1+","+b1+")";

var r2 = Math.round(istep * c1_0[0] + step * c1_1[0]);
var g2 = Math.round(istep * c1_0[1] + step * c1_1[1]);
var b2 = Math.round(istep * c1_0[2] + step * c1_1[2]);
var color2 = "rgb("+r2+","+g2+","+b2+")";

 $('#gradient').css({
   background: "-webkit-gradient("+color1+","+color2+")"}).css({
    background: "linear-gradient("+color1+" 0%, "+color2+" 100%)"});
  
  step += gradientSpeed;
  if ( step >= 1 )
  {
    step %= 1;
    colorIndices[0] = colorIndices[1];
    colorIndices[2] = colorIndices[3];
    
    //pick two new target color indices
    //do not pick the same as the current one
    colorIndices[1] = ( colorIndices[1] + Math.floor( 1 + Math.random() * (colors.length - 1))) % colors.length;
    colorIndices[3] = ( colorIndices[3] + Math.floor( 1 + Math.random() * (colors.length - 1))) % colors.length;
    
  }
}

// Main content
function getImage(ctx){
	var jqxhr = $.get('/random_image', function () {
	        })
    .done(function(data) {
      var split_data = data.split('imagestart');
      var label = split_data[0];
      var split_label = label.split('!')
      //
      global_label = split_label[0];
      im_text = split_label[1].trimLeft(1); //we are wandering into a space at the start of labels at some point in the pipeline :(
      //
      change_title(im_text);
      //
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
    global_color = getRandomColor();
    $('#image_label').html('<p style="color:' + global_color + ';">' + text + '</p>')
}

function getRandomColor() {
    var letters = '0123456789ABCDEF';
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * (letters.length * .5)) + 8];
    }
    return color;
}

function hexToRgb(hex) {
    // Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
    var shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
    hex = hex.replace(shorthandRegex, function(m, r, g, b) {
        return r + r + g + g + b + b;
    });

    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16)
    } : null;
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

function  getTouchPos(canvas, evt) {
  var rect = canvas.getBoundingClientRect(), // abs. size of element
      scaleX = canvas.width / rect.width,    // relationship bitmap vs. element for X
      scaleY = canvas.height / rect.height;  // relationship bitmap vs. element for Y
  return {
    x: (evt.touches[0].screenX - rect.left) * scaleX,   // scale mouse coordinates after they have
    y: (evt.touches[0].screenY - rect.top) * scaleY     // been adjusted to be relative to element
  }
}

function process_coordinates(e){
    var pos = getMousePos(canvas, e);
    posx = pos.x;
    posy = pos.y;
    //gate_coordinates(); //Can probably comment this out
    return [posx,posy]
}

function process_touch_coordinates(e){
    var pos = getTouchPos(canvas, e);
    posx = pos.x;
    posy = pos.y;
    //gate_coordinates(); //Can probably comment this out
    return [posx,posy]
}

function gate_coordinates(){
    if (posx < 0){posx = 0;}
    if (posx > global_width){posx = global_width;}
    if (posy < 0){posy = 0;}
    if (posy > global_height){posy = global_height;}
}

function draw(e) {
    postImage(global_image_link,ctx)
    var pos = process_coordinates(e);
    posx = pos[0];
    posy = pos[1];
    var rgb = hexToRgb(global_color)
    draw_boxes(rgb,click_array);
    if (click_array.length == 0){
        ctx.fillStyle = 'rgba(' + rgb['r'] + ',' +rgb['g'] + ',' + rgb['b'] + ',' + '0.6)';
        ctx.fillRect(posx-half_size, posy-half_size, reveal_size, reveal_size);
    }
}

function draw_touch(e) {
    postImage(global_image_link,ctx)
    var pos = process_touch_coordinates(e);
    posx = pos[0];
    posy = pos[1];
    var rgb = hexToRgb(global_color)
    draw_boxes(rgb,click_array);
    if (click_array.length == 0){
        ctx.fillStyle = 'rgba(' + rgb['r'] + ',' +rgb['g'] + ',' + rgb['b'] + ',' + '0.6)';
        ctx.fillRect(posx-half_size, posy-half_size, reveal_size, reveal_size);
    }
}

function sum(array) {
    var num = 0;
    for (var i = 0, l = array.length; i < l; i++) num += array[i];
    return num;
}

function mean(array) {
    return sum(array) / array.length;
}

function std(array) {
    var mu = mean(array);
    var sums = 0;
    for (var i = 0, l = array.length; i < l; i ++) sums+= Math.pow(array[i] - mu,2);
    return Math.sqrt(sums/l);
}

function compare_clicks(arr){
    if (arr[1] - arr[0] < 300){
        trigger_alert();
    }
}

function trigger_alert(){
    $('#spammer').html('<p style="color:Red">Slow down would ya?</p>')
    setTimeout(function(){
        $('#spammer').html('')
    },3000)
}

function distance(dot1,dot2){
    var x1 = dot1[0],
        y1 = dot1[1],
        x2 = dot2[0],
        y2 = dot2[1];
    return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
    
}

function calc_dist(a,b){
    var dist_array = [];
    for (var i = 0; i < a.length; i++){
        var dist = 0;
        for (var d = 0; d < a[i].length; d++){
            dist+= Math.pow(b[d] - a[i][d],2);
        }
        dist_array.push(Math.sqrt(dist));
    }
    return dist_array;
}

function calculate_new_dist(old_x,old_y,new_x,new_y,old_dist,new_dist){
    if (old_dist > new_dist){
        new_x = new_x - old_x;
        new_y = new_y - old_y;
        var radians = Math.atan2(new_y,new_x);
        new_x = Math.cos(radians) * new_dist + old_x;
        new_y = Math.sin(radians) * new_dist + old_y;
    }
    var new_coors = [new_x,new_y];
    return new_coors;
}

function draw_boxes(rgb,click_array){
    ctx.fillStyle = 'rgba(' + rgb['r'] + ',' +rgb['g'] + ',' + rgb['b'] + ',' + '0.3)';
    for (var idx = 0; idx < click_array.length; idx++){
        ctx.fillRect(click_array[idx][0]-half_size, click_array[idx][1]-half_size, reveal_size, reveal_size);
    }
}

function get_dist(new_x,new_y,old_x,old_y){
    var dist = distance([new_x,new_y],[old_x,old_y]);
    return dist
}

function click_functions(click_posx,click_posy){
    postImage(global_image_link,ctx);
    var rgb = hexToRgb(global_color)
    draw_boxes(rgb,click_array)
    click_array.push([click_posx,click_posy])
}

function novel_coordinate(new_points){
    novel = true;
    for (var idx = 0; idx < click_array.length; idx++){
        if (new_points[0] == click_array[idx][0] & new_points[1] == click_array[idx][1]){
            novel = false;
        }
    }
    return novel;
}

function calculate_new_click(){
    var num_clicks = click_array.length-1;
    true_posx = posx;
    true_posy = posy;
    click_dist = get_dist(click_array[num_clicks][0],click_array[num_clicks][1],true_posx,true_posy);
    var new_points = calculate_new_dist(click_array[num_clicks][0],click_array[num_clicks][1],true_posx,true_posy,click_dist,half_size);
    if (novel_coordinate(new_points) & playing_image){
        click_functions(new_points[0],new_points[1]);
    } //make sure that we're just delaying the drawing/storing process, but that there's a queue of coordinates building up.
}

function check_deviation(){
    var num_clicks = click_array.length-1;    
    var deviation = false;
    if (true_posx !== click_array[num_clicks][0] & true_posy !== click_array[num_clicks][1]){
        deviation = true;
    }
    return deviation;
}

function update_guess(cnn_guess){
    global_guess = cnn_guess;
    $('#ai_guess').html('The AI thinks this is a: ' + cnn_guess);
}

function package_json(click_array,global_label){
    var json_data = {};
    json_data.image_name = global_label;
    json_data.click_array = click_array;
    return JSON.stringify(json_data);
}

function call_sven(){
    $.ajax({
        url: cnn_server,
        type: 'POST',
        data: package_json(click_array,global_label),
        //contentType: 'application/json',
        success: function (data) {
            update_guess(data);
            if (data === im_text){correct_recognition();}
        }
    });
}

function keep_clicking(){
    setTimeout(function(){
        //console.log(check_deviation())
        if (playing_image === false){
            return;
        }
        calculate_new_click();
        keep_clicking();
        if (click_array.length % clicks_till_update === 0){
            call_sven();
        }
    },reveal_rate)
}

function round_reset(correct){
    update_user_data();
    window.removeEventListener('mousedown', clicked, false);
    playing_image = false;
    upload_click_location(click_array,correct);
    click_array = [];
    bar.destroy();
    start_turn();
}

function refresh_gradient(){
var timesRun = 0;
var interval = setInterval(function(){
    timesRun += 1;
    if(timesRun === 60){
        clearInterval(interval);
    }
    updateGradient();
}, 2000); 
}

function correct_recognition(){
    round_reset('correct');
    answer_status(true,answer_status_timer); //make this dissappear after answer_status_timer ms
    add=setInterval(updateGradient,10); //dont think this works
    setTimeout(function(){clearInterval(add);},500)
}

function time_elapsed(){
    round_reset('wrong');
    answer_status(false);
}

function skip_question(){
    round_reset('skip');
    answer_status(false);
}

function answer_status(c_i){
    if (c_i) { //true
        var text_color="#00FF04";
        $('#ai_guess').html('The AI correctly thought this was a: <span style="color:' + text_color + '">' + global_guess + '</span>');
    }else{ //false
        var text_color="#FF330A";
        $('#ai_guess').html('The AI incorrectly thought this was a: <span style="color:' + text_color + '">' + global_guess + '</span>');
    }
    setTimeout(function(){
        $('#ai_guess').html('[Waiting for your next click]');
    },2000)
}

function clicked() {
    if (posx < 0 || posx > global_width || posy < 0 || posy > global_height){}
    else{
        if (click_array.length === 0){
            click_functions(posx,posy);
            playing_image = true;
            keep_clicking();
            bar.animate(1.0,{duration:time_limit},function(){time_elapsed();});
        }
    }
}

function upload_click_location(clicks,correct){
    var data = {};
    data.clicks = clicks;
    data.image_id = global_label;
    data.correct = correct;
    $.ajax({
        type: 'POST',
        url: '/clicks',
        data: data,
        dataType: 'application/json',
        success: function(data) {}
    });
}

function start_turn(){
    getImage(ctx);
    setup_progressbar();
    window.addEventListener('mousemove', draw, false);
    window.addEventListener('mousedown', clicked, false);
}

function update_user_data(){
   	$.get('/user_data', function () { }).done(function(json_data) {
   	    user_data = JSON.parse(json_data);
   	    // Update display
        //if (user_data.email == ''){$("#consentModal").modal('show');}
        $('#click_count').html('Recognized images: ' + user_data.score);
        $('#click_high_score').html('Today\'s high score: ' + user_data.scores.global_high_score);
        $('#login_info').html('Your user name is: ' + user_data.name);
        var accum_clicks = user_data.scores.clicks_to_go;
        var clicks_to_go = user_data.scores.click_goal - accum_clicks;
        update_chart(myChart,accum_clicks,clicks_to_go);
        // High score table
        high_score_table = '';
        hsdata = user_data.scores.high_scores;
        for (var i = 0; i < hsdata.length; ++i)
        {
            high_score_table += '<tr class="align-left"><td>' + (i + 1).toString() + '</td><td>' + hsdata[i].name + '</td><td>' + hsdata[i].score + '</td></tr>'
        }
        $('#high_scores').html(high_score_table);
    });

}

function setup_progressbar(){
    bar = new ProgressBar.Line(progressbar, {
    strokeWidth: 2,
    easing: 'easeOut',
    duration: time_limit,
    color: '#FFEA82',
    trailColor: '#eee',
    trailWidth: 1,
    svgStyle: {width: '40%', height: '80%'},
    from: {color: '#FFEA82'},
    to: {color: '#ED6A5A'},
    step: (state, bar) => {
        bar.path.setAttribute('stroke', state.color);
    }
});

}

function email_check(text){
    if (text.indexOf('@') !== -1){
        $('#agree').disable(false);
    }
}

jQuery.fn.extend({
    disable: function(state) {
        return this.each(function() {
            var $this = $(this);
            $this.toggleClass('disabled', state);
        });
    }
});

function next_date(){
    var D= new Date();
    D.setMonth(D.getMonth()+1,1);
    D.setHours(0, 0, 0, 0);
    return D.toString().split(' 00')[0];
}

function upload_email(){
    var data = {};
    data.email = $('#email').val();
    $.ajax({
        type: 'POST',
        url: '/email',
        data: data,
        dataType: 'application/json',
        success: function(data) {}
    });    
}

function update_email(){
    var data = {};
    data.email = $('#update_email_text').val();
    $.ajax({
        type: 'POST',
        url: '/email',
        data: data,
        dataType: 'application/json',
        success: function(data) {}
    });
}

/////////
$(document).ready(function(){
    // Prepare canvas
    canvas = document.getElementById('myCanvas');
    ctx = canvas.getContext('2d');
    // Adjust canvas element for phones
    if ($(window).width() < canvas.width){
        ctx.canvas.height = $(window).height();
        ctx.canvas.width = $(window).width();
    }
    global_width = canvas.width;
    global_height = canvas.height;
    // Initial score
    update_user_data();
    if ('ontouchstart' in window) {canvas.addEventListener('mousemove', draw, false);} //touchmove
    else{canvas.addEventListener('mousemove', draw, false);}
    canvas.addEventListener('mousedown', clicked, false);
    start_turn();
    // Modals
    $('#scoreboard-modal').click(function(){$("#scoreModal").modal('show');})
    // Tooltips
    $('#agree').tooltip({container: 'body'})
    $('#email').on('input', function(){email_check($('#email').val())});
    $('#skip_button').tooltip({container: 'body'})
    $('#skip_button').click(function(){skip_question()});
    $('#agree').click(function(){upload_email()});
    $('#update_email').click(function(){update_email()});
    // Contest date
    $('#next_prize').text('The top-5 scoring players by ' + next_date()  + ' win a gift-card! See the Scoreboard tab for details.')
    $('#scoreboard_time').text('Prizes awarded to the top-5 players on ' + next_date() + '.')
})
