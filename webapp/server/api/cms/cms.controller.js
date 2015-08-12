'use strict';

var _ = require('lodash');
var mongo = require('mongodb').MongoClient;
var path = require('path');
var fs = require('fs');
var os = require('os');
var http = require('http');
var inspect = require('util').inspect;
var Busboy = require('busboy');
var glob = require('glob');

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

// returns object containing data for all images
exports.get_images = function(req, res) {
  glob('client/assets/images/uploads/*', function(err, files) {
    for (var i = 0; i < files.length; i++) {
      files[i] = path.basename(files[i]);
    }
    res.send(files)
  });
};

// upload a file
exports.post_images = function(req, res) {
  if (req.method === 'POST') {
    var busboy = new Busboy({ headers: req.headers });
    busboy.on('file', function(fieldname, file, filename, encoding, mimetype) {
      var saveTo = path.join(__dirname + '../../../../client/assets/images/uploads/' + path.basename(filename));
      file.pipe(fs.createWriteStream(saveTo));
    });
    busboy.on('finish', function() {
      res.redirect("back");
    });
    return req.pipe(busboy);
  }
  res.writeHead(404);
  res.end();
};

// deletes an image
exports.delete_images = function(req, res) {
  var exists = true;
  fs.open(__dirname + '/../../../client/assets/images/uploads/' + req.query.filename, 'r',
    function(err, fd) {
      if (err && err.code == 'ENOENT')
      {
        return;
      }
      else {
        fs.unlink(__dirname + '/../../../client/assets/images/uploads/' + req.query.filename);
      }
      res.send(200);
    })
};

// returns JSON array of Capabilities
exports.get_capa = function(req, res) {
  res.writeHead(200, { "Content-Type": "application/json" });
  db.collection('data').findOne({name:'data'}, function(err, doc) {
    var json = JSON.stringify(doc.Capabilities);
    res.end(json);
  });
};

// returns JSON array of Products
exports.get_prod = function(req, res) {
  res.writeHead(200, { "Content-Type": "application/json" });
  db.collection('data').findOne({name:'data'}, function(err, doc) {
    var json = JSON.stringify(doc.Products);
    res.end(json);
  });
};

// add a capability
exports.post_capa = function(req, res) {
  db.collection('data').update(
    { name: 'data', },
    { $addToSet: { Capabilities: req.query.capability }}
  );
};

// add a product
exports.post_prod = function(req, res) {
  db.collection('data').update(
    { name: 'data', },
    { $addToSet: { Products: req.query.capability }}
  );
};

// deletes a capability alltogether
exports.delete_capa = function(req, res) {
  res.send('DELETE capa: ' + req.query.message);
};

// deletes a product alltogether
exports.delete_prod = function(req, res) {
  res.send('DELETE prod: ' + req.query.message);
};

// sets big/small slideshow || color/b&w rep flags for an image
exports.post_flags = function(req, res) {
  res.send('POST flags: ' + req.query.message);
};

// deletes big/small slideshow || color/b&w rep flags for an image
exports.delete_flags = function(req, res) {
  res.send('DELETE flags: ' + req.query.message);
};
