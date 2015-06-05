'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var ImagesSchema = new Schema({
  path: String
});

module.exports = mongoose.model('Images', ImagesSchema);
