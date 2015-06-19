'use strict'

angular.module 'webappApp'
.controller 'MainCtrl', ($scope) ->
  $scope.message = 'Hello'

  setColor = () ->
    # color 1: #152F40 - font
    color = '#152F40'
    # color 2: #0A4A59 - background
    color = '#0A4A59'
    # color 3: #06828C -
    color = '#06828C'
    # color 4: #D1F2E9
    color = '#D1F2E9'
    # color 5: #F23D08
    color = '#F23D08'

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
      setColor();
  init()
