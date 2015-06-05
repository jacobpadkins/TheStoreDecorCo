'use strict'

angular.module 'cmsApp'
.controller 'MainCtrl', ($scope) ->

  # scope variables
  imgs = []
  fabs = []
  cats = []
  # functions called inline
  $scope.clickUpload = () ->
    $("#file").click()
  # functions called locally
  getImgs = () ->
    # populate imgs array
  getFabs = () ->
    # populate fabs array
  getCats = () ->
    # populate cats array
  populateImgs = () ->
    getImgs()
    if imgs.length == 0
      $("#imgsList").append("<h6 class=\"alert\">No Images Found!</h6>")
  populateFabs = () ->
    getFabs()
    if fabs.length == 0
      $("#fabsList").append("<h6 class=\"alert\">No Methods Found!</h6>")
  populateCats = () ->
    getCats()
    if cats.length == 0
      $("#catsList").append("<h6 class=\"alert\">No Categories Found!</h6>")
  # run at page load
  init = () ->
    populateImgs()
    populateFabs()
    populateCats()
  init()
