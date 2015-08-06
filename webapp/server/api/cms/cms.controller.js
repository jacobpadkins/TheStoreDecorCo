'use strict';

var _ = require('lodash');
var mongo = require('mongodb').MongoClient;
var path = require('path');
var fs = require('fs');
var os = require('os');
var http = require('http');
var inspect = require('util').inspect;
var Busboy = require('busboy');

var password = '$toreDecor15';
var db;

mongo.connect('mongodb://localhost/cms', function(err, database) {
  if (!err) {
    console.log('DB: connected to db');
    db = database;
    database.createCollection('data', { strict: true }, function(err, collection) {
      if (!err) {
        var data_doc = { name: 'data', 'Capabilities': [], 'Products': [] }
        collection.insert(data_doc);
      }
    });
  }
});

// returns JSON array of Capabilities
exports.getCapas = function(req, res) {
  res.writeHead(200, { "Content-Type": "application/json" });
  db.collection('data').findOne({name:'data'}, function(err, doc) {
    var json = JSON.stringify(doc.Capabilities);
    res.end(json);
  });
};

// returns JSON array of Products
exports.getProds = function(req, res) {
  res.writeHead(200, { "Content-Type": "application/json" });
  db.collection('data').findOne({name:'data'}, function(err, doc) {
    var json = JSON.stringify(doc.Products);
    res.end(json);
  });
};

// add a capability
exports.addCapa = function(req, res) {
  db.collection('data').update(
    { name: 'data', },
    { $addToSet: { Capabilities: req.query.capability }}
  );
};

// add a product
exports.addProd = function(req, res) {
  db.collection('data').update(
    { name: 'data', },
    { $addToSet: { Products: req.query.capability }}
  );
};

// upload a file
exports.upload = function(req, res) {
  if (req.method === 'POST') {
    var busboy = new Busboy({ headers: req.headers });
    busboy.on('file', function(fieldname, file, filename, encoding, mimetype) {
      var saveTo = path.join(__dirname + '/' + path.basename(filename));
      file.pipe(fs.createWriteStream(saveTo));
    });
    busboy.on('finish', function() {
      res.writeHead(200, { 'Connection': 'close' });
      res.end("upload complete");
    });
    return req.pipe(busboy);
  }
  res.writeHead(404);
  res.end();
  //res.redirect("back");
};
