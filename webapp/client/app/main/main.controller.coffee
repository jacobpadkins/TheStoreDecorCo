'use strict'

angular.module 'webappApp'
.controller 'MainCtrl', ($scope, $http) ->
  $scope.awesomeThings = []

  $http.get('/api/things').success (awesomeThings) ->
    $scope.awesomeThings = awesomeThings

  ### NEW STUFF ###

  ### VARIABLES ###
  $scope.whichPage = 0 # 0 = home, 1 = capa., 2 = prod., 3 = serv.

  $scope.init = () ->
    # $(document).ready() equivalent

  $scope.init()
