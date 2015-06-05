'use strict'

angular.module 'cmsApp'
.controller 'MainCtrl', ($scope) ->
  # file upload w/ progress
  $scope.onFileSelect = (image) ->
    $scope.uploadInProgress = true
    $scope.uploadProgress = 0
    if angular.isArray(image)
      image = image[0]
    $scope.upload = $upload.upload(
      url: '/api/upload/image',
      method: 'POST',
      file: image
    ).progress((event) ->
      $scope.uploadProgress = Math.floor(event.loaded / event.total)
      $scope.$apply()
      return
    ).success((data, status, headers, config) ->
      AlertService.success 'image uploaded'
      return
    ).error((err) ->
      $scope.uploadInProgress = false
      AlertService.error 'error uploading image' + err.message or err
      return
    )
    return
