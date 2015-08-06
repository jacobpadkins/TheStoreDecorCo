'use strict';

var express = require('express');
var controller = require('./cms.controller');

var router = express.Router();

router.get('/', controller.get);
router.get('/getCapas', controller.getCapas);
router.get('/getProds', controller.getProds);
router.post('/addCapa', controller.addCapa);
router.post('/addProd', controller.addProd);

module.exports = router;
