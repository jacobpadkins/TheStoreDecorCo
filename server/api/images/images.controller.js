'use strict';

var _ = require('lodash');
var Images = require('./images.model');
var Busboy = require('busboy');
var http = require('http')
var inspect = require('util').inspect;
var fs = require('fs');

// Get list of images
exports.index = function(req, res) {
  Images.find(function (err, images) {
    if(err) { return handleError(res, err); }
    return res.json(200, images);
  });
};

// Get a single images
exports.show = function(req, res) {
  Images.findById(req.params.id, function (err, images) {
    if(err) { return handleError(res, err); }
    if(!images) { return res.send(404); }
    return res.json(images);
  });
};

// Creates a new images in the DB.
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
  /*Images.create(req.body, function(err, images) {
    if(err) { return handleError(res, err); }
    console.log(images);
    return res.json(201, images);
  });*/
};

// Updates an existing images in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Images.findById(req.params.id, function (err, images) {
    if (err) { return handleError(res, err); }
    if(!images) { return res.send(404); }
    var updated = _.merge(images, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.json(200, images);
    });
  });
};

// Deletes a images from the DB.
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
