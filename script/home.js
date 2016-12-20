var global_image_link; //globals :(. Should rethink this at some point.
var global_label, im_text;
var global_color = "#ffffff";
var user_data = { };
var previous_loc = 0;//[0,0];
var cnn_server = '/guess';
var click_array = [];
var reveal_size = 14;
var half_size = Math.round(reveal_size/2);
var reveal_rate = 50;
var playing_image = false;
var clicks_till_update = 10; //Clicks between server calls
var time_limit = 7000;
var answer_status_timer = 2500;
var global_precision = 2;
var max_in = 0;
var prev_max = 0;
var num_turns = 0;
var remove_info_after = 3;
var mobile = false;
var posx, posy, true_posx, true_posy, global_guess, global_width, global_height, imgLoaded,image;

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
    if (mobile){
        $('#gradient').css({'height':String(parseInt(window.innerHeight) + 300)+ 'px'});
    }else{
        $('#gradient').css({'height':window.innerHeight + 'px'});
    }
  
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
    image = new Image();
    imgLoaded = false;
    image.src = 'data:image/jpg;base64,' + image_link;
    image.onload = function(){
        ctx.drawImage(image,0,0);
        imgLoaded = true;
        draw_scored_box(0);
    }
    //try{
    //    ctx.drawImage(image,0,0);
    //}catch(err){}
    
}

function change_title(text){
    global_color = getRandomColor();
    //$('#image_label').html('<p style="color:' + global_color + ';">' + text + '</p>')
    $('#image_label').html('<p style="color:' + global_color  + ';">' + text + '</p>')
}

function getRandomColor() {
    var letters = '0123456789ABCDEF';
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.floor(Math.random() * (4)) + 12];
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

function getTouchPos(canvas, evt) {
  if(evt.targetTouches.length == 1){ //one finger touch
    var touch = event.targetTouches[0];
    var rect = canvas.getBoundingClientRect(), // abs. size of element
      scaleX = canvas.width / rect.width,    // relationship bitmap vs. element for X
      scaleY = canvas.height / rect.height;  // relationship bitmap vs. element for Y
    return {
      x: (touch.clientX - rect.left) * scaleX,   // scale mouse coordinates after they have
      y: (touch.clientY - rect.top) * scaleY     // been adjusted to be relative to element
    }
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

function fastDraw(){
    if (imgLoaded) ctx.drawImage(image,0,0);
}
function draw(e) {
    //postImage(global_image_link,ctx)
    fastDraw();
    interp_box();
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
    //postImage(global_image_link,ctx)
    e.preventDefault();
    fastDraw();
    interp_box();
    var pos = process_touch_coordinates(e);
    posx = pos[0];
    posy = pos[1];
    var rgb = hexToRgb(global_color)
    draw_boxes(rgb,click_array);
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
    //postImage(global_image_link,ctx);
    fastDraw();
    interp_box();
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

function get_colors(max_idx,correct_idx){
    colors = [];
    for (var idx = 0; idx < max_idx; idx++){
        if (correct_idx === idx){colors[idx] = "#00FF04";}
        else{colors[idx] = "#FF330A";}
    }
}

function update_guess(cnn_guess,cc){
    //get_colors(4,cc) //range(0,4) + color cc index as green
    global_guess = cnn_guess[0];
    $('#ai_guess').html('<span style="color:' + colors[0] + '">The AI thinks this is likely a: ' + cnn_guess[0] + '</span>');
    $('#g2').html('<span style="color:' + colors[1] + '">' + cnn_guess[1] + '</span>');
    $('#g3').html('<span style="color:' + colors[2] + '">' + cnn_guess[2] + '</span>');
    $('#g4').html('<span style="color:' + colors[3] + '">' + cnn_guess[3] + '</span>');
    $('#g5').html('<span style="color:' + colors[4] + '">' + cnn_guess[4] + '</span>');
}

function package_json(click_array,global_label){
    var json_data = {};
    json_data.image_name = global_label;
    json_data.click_array = click_array;
    return JSON.stringify(json_data);
}

function check_correct(split_guesses,im_text){
    var ci = -1;
    var answer = false;
    for (var idx = 0; idx < 5;idx++){ //Top-5 recognition
        if (split_guesses[idx] === im_text){
            ci = idx;
            answer = true;
        }
    }
    return [ci,answer];
}

function str_to_float(data){
   var out = [];
   for (var idx = 0; idx < data.length - 1; idx++){
       out[idx] = parseFloat(data[idx]);
   }
   return out
}

function find_target_pp(split_guesses,im_text){
    var target;
    for (var idx = 0; idx < split_guesses.length; idx++){
        if (split_guesses[idx] === im_text){
            return idx
        }
    }
}

function call_sven(){
    $.ajax({
        url: cnn_server,
        type: 'POST',
        data: package_json(click_array,global_label),
        //contentType: 'application/json',
        success: function (data) {
            var guess_pp = data.split('@');
            var pps = str_to_float(guess_pp[1].split('!'));
            var split_guesses = guess_pp[0].split('!'); //delimited with !
            var cc = check_correct(split_guesses,im_text);
            max_in = pps[find_target_pp(split_guesses,im_text)] * 100;
            var max_non = Math.max.apply(null,pps.splice(5,pps.length)) * 100;
            if (isNaN(max_in)) {max_in = 0;}
            if (cc[1] === true){
                //update_pps(ppChart,max_in,max_non);
                //correct_recognition(0,max_in);
                correct_recognition(0,(1 - bar.value()) * 100);
                max_in = 0;
            }else{
                //update_pps(ppChart,max_in,max_non)
            }
        }
    });
}

function interp_box(){
   //var color_score = cs_map(prev_max/100);
   //draw_scored_box(color_score);
   draw_scored_box(0);
   /*var color_score;
   var num_steps = 100 * (Math.abs(max_in - prev_max) * 0.1);
   for (var idx = 0; idx < num_steps; idx++){
       setTimeout(function(){
           color_score = cs_map(prev_max/100);
           draw_scored_box(color_score);
           if (prev_max < max_in){
               prev_max+=0.1;
           }else if (prev_max > max_in){
               prev_max-=0.1;
           }
       },10); 
   }*/
}

function draw_scored_box(color_score){
    //var color_score = cs_map(max_in/100);
    ctx.beginPath();
    //ctx.strokeStyle = 'rgb('+color_score._rgb[0]+', '+color_score._rgb[1]+', '+color_score._rgb[2] + ')';
    ctx.strokeStyle = global_color;//'white';
    ctx.lineWidth = 5;
    ctx.rect(0,0,global_height,global_width);
    ctx.stroke();
    ctx.closePath();
}

function keep_clicking(){
    setTimeout(function(){
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
    //window.removeEventListener('mousedown', clicked, false);
    playing_image = false;
    upload_click_location(click_array,correct);
    num_turns++;
    click_array = [];
    bar.destroy();
    start_turn();
}

function refresh_gradient(){
    var startTime = new Date().getTime();
    var interval = setInterval(function(){
        if(new Date().getTime() - startTime > 1000){
            clearInterval(interval);
            return;
        } 
        updateGradient();
    }, 2000); 
}

function correct_recognition(wc,pp){
    if (wc == 0){round_reset(pp);}
    answer_status(wc,answer_status_timer,pp); //make this dissappear after answer_status_timer ms
    //refresh_gradient();
    var si =setInterval(updateGradient,10); //dont think this works
    setTimeout(function(){clearInterval(si);},500)
}

function time_elapsed(){
    round_reset('wrong');
    answer_status(false);
}

function skip_question(){
    round_reset('skip');
    answer_status(-1);
}

function answer_status(c_i,answer_status_timer,pp){
    if (global_guess == undefined){global_guess = '???';}
    if (typeof(c_i) === 'boolean'){
        if (c_i === false){
            var text_color="#FF330A";
            $('#text_feedback').html('<span style="color:' + text_color + '">Time elapsed!</span>');
            revert_title();
        }
    } else{
        if (c_i >= 0) { //true
            var text_color="#00FF04";
            $('#text_feedback').html('<span style="text-outline:' + text_color + '">+' + String(pp.toFixed(global_precision)) + ' points!</span>');
        }
        else if (c_i < 0){
            $('#text_feedback').html('Image skipped.');
        }
        revert_title();
    }
}

function revert_title(){
    setTimeout(function(){
        $('#text_feedback').html('_____');
    },answer_status_timer)
}

function clicked(e) {
    if (posx < 0 || posx > global_width || posy < 0 || posy > global_height){}
    else{
        if (click_array.length === 0){
            if (mobile){freeze();
               var pos = process_touch_coordinates(e);
               posx = pos[0];
               posy = pos[1];
            }            
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
    if (mobile){
        canvas.addEventListener('touchmove', draw_touch, false);
        canvas.addEventListener('touchstart', clicked, false);
    }else{
        canvas.addEventListener('mousemove', draw, false);
        canvas.addEventListener('mousedown', clicked, false);
    }
    if (num_turns > remove_info_after){
        if (mobile){}else{
            $('#next_prize').fadeOut();
        }
        $('#extra_info').fadeOut();
    }
}

function prepare_mobile(){
            smoothScroll.init({callback: function(){freeze();
                $('#next_prize').html('<button id="scrolling" style="color:black;background-color:white;height:20px;font-size:66%;margin-top:0px;margin-bottom:5px;line-height:5px;">Tap to enable scrolling</button>');
                $('#next_prize').click(function(){unfreeze();});
            }});
            setTimeout(function(){
                smoothScroll.animateScroll(80);
                window.scrollTo(0,80);
            },1000)
}

function update_user_data(){
   	$.get('/user_data', function () { }).done(function(json_data) {
   	    user_data = JSON.parse(json_data);
   	    // Update display
        if (user_data.email == ''){
            $("#consentModal").modal('show');
            $("#consentModal").on('hidden',function(){
                $("#instructionModal").modal('show');
                if (mobile){
                    $("#instructionModal").on('hidden',function(){prepare_mobile()});
                }
            });
        }else{if (mobile && num_turns > 0){prepare_mobile();}}
        //if (user_data.email == ''){$('#instruction-modal').modal('show');}
        $('#click_count').html('Your score: ' + user_data.score.toFixed(global_precision));
        $('#click_high_score').html('High score: ' + user_data.scores.global_high_score.toFixed(global_precision));
        if (mobile){$('#login_info').html('Username: ' + user_data.name);}else{
        $('#login_info').html('Your user name is: ' + user_data.name);}
        var accum_clicks = user_data.scores.clicks_to_go;
        var clicks_to_go = user_data.scores.click_goal - accum_clicks;
        update_chart(myChart,accum_clicks,clicks_to_go);
        // High score table
        high_score_table = '';
        hsdata = user_data.scores.high_scores;
        var tt;
        for (var i = 0; i < hsdata.length; ++i)
        {
            if (i == 0){tt = 'info'}
            else if (i == 1){tt = 'success'}
            else if (i == 2){tt = 'warning'}
            else if (i == 3){tt = 'danger'}
            else if (i == 4){tt = 'active'}
            else {tt = '';}
            high_score_table += '<tr class="' + tt + '"><td>' + (i + 1).toString() + '</td><td>' + hsdata[i].name + '</td><td>' + hsdata[i].score.toFixed(global_precision) + '</td></tr>'
        }
        $('#high_scores').html(high_score_table);
    }).fail(function(){update_user_data()});
}

function setup_progressbar(){
    bar = new ProgressBar.Line(progressbar, {
    strokeWidth: 2,
    easing: 'easeOut',
    duration: time_limit,
    color: '#FFEA82',
    trailColor: '#eee',
    trailWidth: 1,
    svgStyle: {width: '210px', height: '80%'},
    from: {color: '#FFEA82'},
    to: {color: '#ED6A5A'},
    step: (state, bar) => {
        bar.path.setAttribute('stroke', state.color);
    }
});

}

function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function email_check(text){
    //if (text.indexOf('@') !== -1){
    if (validateEmail(text)){
        $('#agree').disable(false);
        $('#update_email_modal').disable(false);
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
    console.log('here')
    var data = {};
    data.email = $('#update_email_text_modal').val();
    $.ajax({
        type: 'POST',
        url: '/email',
        data: data,
        dataType: 'application/json',
        success: function(data) {}
    });
}

function check_email(){
    var new_email = user_data.email; if (new_email == ''){new_email = 'Enter your email so we can contact you if you win.'};
    return new_email
}

//Freeze page content scrolling
var keys = {37: 1, 38: 1, 39: 1, 40: 1};

function preventDefault(e) {
  e = e || window.event;
  if (e.preventDefault)
      e.preventDefault();
  e.returnValue = false;  
}

function preventDefaultForScrollKeys(e) {
    if (keys[e.keyCode]) {
        preventDefault(e);
        return false;
    }
}

function disableScroll() {
  if (window.addEventListener) // older FF
      window.addEventListener('DOMMouseScroll', preventDefault, false);
  window.onwheel = preventDefault; // modern standard
  window.onmousewheel = document.onmousewheel = preventDefault; // older browsers, IE
  window.ontouchmove  = preventDefault; // mobile
  document.onkeydown  = preventDefaultForScrollKeys;
}

function enableScroll() {
    if (window.removeEventListener)
        window.removeEventListener('DOMMouseScroll', preventDefault, false);
    window.onmousewheel = document.onmousewheel = null; 
    window.onwheel = null; 
    window.ontouchmove = null;  
    document.onkeydown = null;  
}

function freeze() {
    disableScroll();
}
//Unfreeze page content scrolling
function unfreeze() {
    enableScroll();
}
/////////
// device detection
if (/Mobi/.test(navigator.userAgent)) {
    mobile = true;
}

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
    if (mobile) {
        canvas.addEventListener('touchmove', draw_touch, false);
        canvas.addEventListener('touchstart', clicked, false);
        $('#extra_info').html('Drag your finger across the image to reveal parts best describing a:');
    }
    else{
        canvas.addEventListener('mousemove', draw, false);
        canvas.addEventListener('mousedown', clicked, false);
    }
    start_turn();
    // Modals
    $('#scoreboard-modal').click(function(){$("#scoreModal").modal('show');});
    $('#instruction-modal').click(function(){$("#update_email_text_modal").attr('placeholder',check_email());$('#instructionModal').modal('show');});
    // Tooltips
    $('#email').on('input', function(){email_check($('#email').val())});
    if (mobile === false){
        $('#skip_button').tooltip({container: 'body',trigger: 'hover'});
        $('#agree').tooltip({container: 'body'});
    }else{
        $('#skip_button').css({'background-color':'white'});
    }
     
    $('#skip_button').click(function(){skip_question()});
    $('#agree').click(function(){upload_email();$("#consentModal").modal('hide');});
    $('#update_email_modal').click(function(){update_email()});
    $('#update_email_text_modal').on('input', function(){email_check($('#update_email_text_modal').val());});
    // Contest date
    $('#next_prize').text('The top-5 scoring players by ' + next_date()  + ' win a gift card! See the Scoreboard tab for details.');
    $('#scoreboard_time_1').text('Amazon gift cards awarded to the top-5 scoring players on ' + next_date() + ' in the following amounts:');
    $('#scoreboard_time_2').text('Amazon gift cards awarded to the top-5 scoring players on ' + next_date() + ' in the following amounts:');
    // Refresh the screen for mobile
    // adjust_for_mobile();
})
