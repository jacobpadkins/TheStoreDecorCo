'use strict'

angular.module 'webappApp'
.controller 'MainCtrl', ($scope) ->
  $scope.message = 'Hello'

  init = () ->
      $('#colCapa img').on 'mouseover', () ->
        #
        $('#colCapa img').on 'mouseleave', () ->
          #
      $('#colServ img').on 'mouseover', () ->
        #
        $('#colCapa img').on 'mouseleave', () ->
          #
      $('#colProd img').on 'mouseover', () ->
        #
        $('#colCapa img').on 'mouseleave', () ->
          #
  init()
