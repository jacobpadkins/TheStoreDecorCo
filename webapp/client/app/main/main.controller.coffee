'use strict'

angular.module 'webappApp'
.controller 'MainCtrl', ($scope) ->
  $scope.message = 'Hello'

  init = () ->
      $('#colCapa').on 'click', () ->
        console.log 'you clicked Capabilities'
      $('#colServ').on 'click', () ->
        console.log 'you clicked Services'
      $('#colProd').on 'click', () ->
        console.log 'you clicked Products'
  init()
