'use strict'

angular.module 'cmsApp'

.directive 'fileModel', [
  '$parse'
  ($parse) ->
    {
      restrict: 'A'
      link: (scope, element, attrs) ->
        model = $parse(attrs.fileModel)
        modelSetter = model.assign
        element.bind 'change', ->
          scope.$apply ->
            modelSetter scope, element[0].files[0]
            return
          return
        return
    }
]

.service 'fileUpload', [
  '$http'
  ($http) ->

    @uploadFileToUrl = (file, uploadUrl) ->
      fd = new FormData
      fd.append 'file', file
      $http.post(uploadUrl, fd,
        transformRequest: angular.identity
        headers: 'Content-Type': undefined).success(->
      ).error ->
      return

    return
]

.controller 'MainCtrl', [
  '$scope', 'fileUpload'
  ($scope, fileUpload) ->

    # VARIABLES #
    $scope.imgs = []
    $scope.fabs = []
    $scope.cats = []

    # INLINE #
    $scope.clickUpload = () ->
      $("#file").click()
      return

    # LOCAL #

    uploadFile = () ->
      if $scope.myFile != undefined
        file = $scope.myFile
        $scope.myFile = undefined
        console.log 'file is ' + JSON.stringify(file)
        uploadUrl = 'api/images'
        fileUpload.uploadFileToUrl file, uploadUrl
      return

    getImgs = () ->
      # populate imgs array
      $scope.imgs.push "an image url"
      $scope.imgs.push "another image url"
      return

    getFabs = () ->
      # populate fabs array

    getCats = () ->
      # populate cats array

    populateImgs = () ->
      getImgs()
      if $scope.imgs.length == 0
        $("#imgsList").append("<h6 class=\"alert\">No Images Found!</h6>")
        return

    populateFabs = () ->
      getFabs()
      if $scope.fabs.length == 0
        $("#fabsList").append("<h6 class=\"alert\">No Methods Found!</h6>")
        return

    populateCats = () ->
      getCats()
      if $scope.cats.length == 0
        $("#catsList").append("<h6 class=\"alert\">No Categories Found!</h6>")
        return

    # RUN AT PAGE LOAD #
    init = () ->
      populateImgs()
      populateFabs()
      populateCats()
      $('#file').on 'click', () ->
        $('#file').on 'change', () ->
          uploadFile()
      return

    init()
]
