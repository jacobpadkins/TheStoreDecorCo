'use strict'

angular.module 'webappApp'
.controller 'CmsCtrl', ($scope, $http) ->

  # basically $(document).ready()
  init = () ->

    $http({
      url: 'api/cms/addCapa',
      method: 'POST',
      params: {capability: "test_capa2"}
    })

    $http({
      url: 'api/cms/getCapas',
      method: 'GET',
    }).success( (response) ->
      console.log response
    )

    $http({
      url: 'api/cms',
      method: 'GET',
      params: {message: 'GET is working', password: '$toreDecor15'}
    }).success( (response) ->
      $('p').text response.object.message
    )

  init()
