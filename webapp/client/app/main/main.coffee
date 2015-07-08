'use strict'

angular.module 'webappApp'
.config ($stateProvider) ->
  $stateProvider.state 'main',
    url: '/'
    templateUrl: 'app/main/main.html'
    controller: 'MainCtrl'
