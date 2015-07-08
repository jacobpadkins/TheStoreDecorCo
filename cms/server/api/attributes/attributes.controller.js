'use strict';

var _ = require('lodash');
var Attributes = require('./attributes.model');

// Get list of attributess
exports.index = function(req, res) {
  Attributes.find(function (err, attributess) {
    if(err) { return handleError(res, err); }
    return res.json(200, attributess);
  });
};

// Get a single attributes
exports.show = function(req, res) {
  Attributes.findById(req.params.id, function (err, attributes) {
    if(err) { return handleError(res, err); }
    if(!attributes) { return res.send(404); }
    return res.json(attributes);
  });
};

// Creates a new attributes in the DB.
exports.create = function(req, res) {
  Attributes.create(req.body, function(err, attributes) {
    if(err) { return handleError(res, err); }
    return res.json(201, attributes);
  });
};

// Updates an existing attributes in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Attributes.findById(req.params.id, function (err, attributes) {
    if (err) { return handleError(res, err); }
    if(!attributes) { return res.send(404); }
    var updated = _.merge(attributes, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.json(200, attributes);
    });
  });
};

// Deletes a attributes from the DB.
exports.destroy = function(req, res) {
  Attributes.findById(req.params.id, function (err, attributes) {
    if(err) { return handleError(res, err); }
    if(!attributes) { return res.send(404); }
    attributes.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.send(204);
    });
  });
};

function handleError(res, err) {
  return res.send(500, err);
}