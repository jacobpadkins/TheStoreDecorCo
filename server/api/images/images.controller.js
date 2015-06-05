'use strict';

var _ = require('lodash');
var Images = require('./images.model');

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
  Images.create(req.body, function(err, images) {
    if(err) { return handleError(res, err); }
    console.log(images);
    return res.json(201, images);
  });
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
