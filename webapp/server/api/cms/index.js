'use strict';

var express = require('express');
var controller = require('./cms.controller');
var router = express.Router();

router.get('/images', controller.get_images);
router.post('/images', controller.post_images);
router.put('/images', controller.put_images);
router.delete('/images', controller.delete_images);
router.get('/capa', controller.get_capa);
router.post('/capa', controller.post_capa);
router.delete('/capa', controller.delete_capa);
router.get('/prod', controller.get_prod);
router.post('/prod', controller.post_prod);
router.delete('/prod', controller.delete_prod);
router.get('/flags', controller.get_flags);
router.put('/flags', controller.put_flags);

module.exports = router;
