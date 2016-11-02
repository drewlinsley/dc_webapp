
var fs = require('fs');
var path = require('path');
fs.exists = fs.exists || path.exists;

exports.handle = function (pieces, request, response) {
  // HTML5 video streaming server piece
  var fileType = request.path.split('.').pop();
  if (fileType == 'mp4' || fileType == 'MP4') {
    var videoFile = unescape(request.path);
    // add case to add the path to the server if serving the homepage bird header
    if (videoFile === '/img/header-bird.mp4') {
      videoFile = path.join(__dirname, 'static', videoFile);
    }
    // use request.path as the filename
    fs.exists(videoFile, function (exists) {
      // if the first piece of the path is /media then are serving a video, need to
      // format filename differently
      if (!exists) {
        response.sendFile('/static/html/404.html', {root : __dirname});
        return;
      }
      // make the filename the path of the request which is the absolute path
      // to the video (such as /media/data/zack/video.mp4)
      var maxVideoRequestChunk = 2 * 1024 * 1024;
      fs.stat(videoFile, function (err, stat) {
        var total = stat.size;
        if (request.headers.range) {
          var range = request.headers.range;
          var parts = range.replace(/bytes=/, '').split('-');
          var partialstart = parts[0];
          var partialend = parts[1];
          var start = parseInt(partialstart, 10);
          var defaultEnd = Math.min(total - 1, start + maxVideoRequestChunk);
          var end = partialend ? parseInt(partialend, 10) : defaultEnd;// total - 1;
          end = (end < 0) ? defaultEnd : end;
          var chunksize = (end - start) + 1;
          var file = fs.createReadStream(videoFile, {start: start, end: end});
          response.writeHead(206, {
            'Content-Range': 'bytes ' + start + '-' + end + '/' + total,
            'Accept-Ranges': 'bytes',
            'Content-Length': chunksize,
            'Content-Type': 'video/mp4'
          });
          file.pipe(response);
        } else {
          response.writeHead(200, {'Content-Length': total, 'Content-Type': 'video/mp4'});
          fs.createReadStream(videoFile).pipe(response);
        }
      });
    });
    return;
  }

  var filename = path.join(process.cwd() + '/static', pieces.join('/'));
  // serve a file
  fs.exists(filename, function (exists) {
    if (!exists) {
      response.sendFile('/static/html/404.html', {root : __dirname});
      return;
    }
    fs.stat(filename, function (err, stat) {
      if (stat.isDirectory()) {
        filename += 'index.html';
      }
      fs.readFile(filename, 'binary', function (err, file) {
        if (err) {
          response.writeHead(500, {'Content-Type': 'text/plain'});
          response.write(err);
          response.end();
          return;
        }
        // get the content type of the file by splitting over periods and getting
        // the last one
        response.writeHead(200, contentType(filename.split('.').slice(-1)[0]));
        response.write(file, 'binary');
        response.end();
      });
    });
  });

  var contentType = function (ext) {
    var ct;
    switch (ext) {
    case '':
      ct = 'text/html';
      break;
    case '/':
      ct = 'text/html';
      break;
    case 'html':
      ct = 'text/html';
      break;
    case 'jpg':
      ct = 'image/jpeg';
      break;
    case 'css':
      ct = 'text/css';
      break;
    case 'js':
      ct = 'text/javascript';
      break;
    default:
      ct = 'text/plain';
      break;
    }
    return {'Content-Type': ct};
  };
};