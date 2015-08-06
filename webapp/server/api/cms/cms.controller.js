'use strict';

var _ = require('lodash');
var mongo = require('mongodb').MongoClient;
var db;
var password = '$toreDecor15';

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

exports.get = function(req, res) {
  if (req.query.password === password) {
    res.writeHead(200, { "Content-Type": "application/json" });
    var test_object = { message: req.query.message };
    var json = JSON.stringify({ object: test_object });
    res.end(json);
  }
  else {
    res.writeHead(200, { "Content-Type": "application/json" });
    var test_object = { message: "wrong password" };
    var json = JSON.stringify({ object: test_object });
    res.end(json);
  }
};

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

exports.addProd = function(req, res) {
  db.collection('data').update(
    { name: 'data', },
    { $addToSet: { Products: req.query.capability }}
  );
};
