'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var AttributesSchema = new Schema({
  name: String,
  info: String,
  active: Boolean
});

module.exports = mongoose.model('Attributes', AttributesSchema);