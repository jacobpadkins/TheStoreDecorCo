'use strict'

angular.module 'cmsApp'
.controller 'MainCtrl', ($scope) ->

  # scope variables
  $scope.imgs = []
  $scope.fabs = []
  $scope.cats = []
  # functions called inline
  $scope.clickUpload = () ->
    $("#file").click()
  # functions called locally
  getImgs = () ->
    # populate imgs array
    $scope.imgs.push "an image url"
    $scope.imgs.push "another image url"
  getFabs = () ->
    # populate fabs array
  getCats = () ->
    # populate cats array
  populateImgs = () ->
    getImgs()
    if $scope.imgs.length == 0
      $("#imgsList").append("<h6 class=\"alert\">No Images Found!</h6>")
    else
  populateFabs = () ->
    getFabs()
    if $scope.fabs.length == 0
      $("#fabsList").append("<h6 class=\"alert\">No Methods Found!</h6>")
  populateCats = () ->
    getCats()
    if $scope.cats.length == 0
      $("#catsList").append("<h6 class=\"alert\">No Categories Found!</h6>")
  # run at page load
  init = () ->
    populateImgs()
    populateFabs()
    populateCats()
  init()
