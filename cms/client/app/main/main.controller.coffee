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
  '$scope', 'fileUpload', '$http'
  ($scope, fileUpload, $http) ->

    $http.get('api/images').success (imgNames) ->
      $scope.imgs = imgNames

    # VARIABLES #
    # $scope.imgs = []
    $scope.fabs = []
    $scope.cats = []
    stickyClick = false
    deleteMode = false

    # INLINE #
    $scope.clickUpload = () ->
      $("#file").click()
      return

    $scope.deleteImage = () ->
      deleteMode = true

    # LOCAL #

    uploadFile = () ->
      if $scope.myFile != undefined
        file = $scope.myFile
        $scope.myFile = undefined
        console.log 'file is ' + JSON.stringify(file)
        uploadUrl = 'api/images'
        fileUpload.uploadFileToUrl file, uploadUrl
      getImgs()
      return

    getImgs = () ->
      $http.get('api/images').success (imgNames) ->
        $scope.imgs = imgNames

    getFabs = () ->
      # populate fabs array

    getCats = () ->
      # populate cats array

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

    setImage = (image) ->
      path = 'url("../../assets/images/' + image + '")'
      $('#image').css('background-image', path)

    # RUN AT PAGE LOAD #
    init = () ->
      populateFabs()
      populateCats()
      # image upload
      $('#file').on 'click', () ->
        $('#file').on 'change', () ->
          uploadFile()
      # image hover preview
      $(document).on 'mouseover', '#imgsList p', () ->
        setImage($(this).text())
      $(document).on 'mouseout', '#imgsList p', () ->
        $('#image').css('background-image', '')
      return

    init()
]
