'use strict';

var _ = require('lodash');
var Images = require('./images.model');
var Busboy = require('busboy');
var http = require('http')
var inspect = require('util').inspect;
var fs = require('fs');
var path = require('path');

// Returns a list of the names of the files in the assets folder
exports.index = function(req, res) {
  var p = __dirname + '/../../../client/assets/images/';
  var names = [];
  fs.readdir(p, function(err, files) {
    if (err) {
      throw err;
    }
    files.map(function(file) {
      return path.join(p, file);
    }).filter(function(file) {
      return fs.statSync(file).isFile();
    }).forEach(function(file) {
      names.push(baseName(file) + path.extname(file));
      console.log(baseName(file) + path.extname(file));
    });
    console.log('Files: ' + names);
    return res.send(200, JSON.stringify(names));
  });
};

// Uploads a multipart/image file to assets folder
exports.create = function(req, res) {
  var busboy = new Busboy({ headers: req.headers });
  busboy.on('file', function(fieldname, file, filename, encoding, mimetype) {
    console.log('File [' + fieldname + ']: filename: ' + filename + ', encoding: ' + encoding + ', mimetype: ' + mimetype);
    // upload file
    var fstream = fs.createWriteStream(__dirname + '/../../../client/assets/images/' + filename);
    file.pipe(fstream);
    fstream.on('close', function() {
      //res.redirect('back');
      console.log("Finished Upload!");
    });
    file.on('data', function(data) {
      console.log('File [' + fieldname + '] got ' + data.length + ' bytes');
    });
    file.on('end', function() {
      console.log('File [' + fieldname + '] Finished');
    });
  });
  busboy.on('field', function(fieldname, val, fieldnameTruncated, valTruncated) {
    console.log('Field [' + fieldname + ']: value: ' + inspect(val));
  });
  busboy.on('finish', function() {
    console.log('Done parsing form!');
    res.writeHead(303, { Connection: 'close', Location: '/' });
    res.end();
  });
  req.pipe(busboy);
};

// Delete Image
exports.destroy = function(req, res) {
  Images.findById(req.params.id, function (err, images) {
    if(err) { return handleError(res, err); }
    if(!images) { return res.send(404); }
    images.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.send(204);
    });
  });
};

function handleError(res, err) {
  return res.send(500, err);
}

// Thanks Stack Overflow
function baseName(str) {
  var base = new String(str).substring(str.lastIndexOf('/') + 1);
  if(base.lastIndexOf(".") != -1)
    base = base.substring(0, base.lastIndexOf("."));
  return base;
}
