'use strict'

angular.module 'webappApp'
.controller 'MainCtrl', ($scope, $http) ->
  $scope.awesomeThings = []

  $http.get('/api/things').success (awesomeThings) ->
    $scope.awesomeThings = awesomeThings

  #   NEW STUFF   #

  ### VARIABLES ###
  $scope.whichPage = 0 # 0 = home, 1 = capa., 2 = prod., 3 = serv.

  ### FUNCTIONS ###
  moveIcons = () ->
    $('.topOption').fadeIn 'slow'
    $('.row hr').css('margin-top', '0em')
  $scope.init = () ->
    $('.topOption').fadeOut 0
    # $(document).ready() equivalent
    $('.option').on 'click', ->
      $(this).effect "highlight", {color:'blue'}, 500, ->
        $('.option').fadeOut 'slow', ->
          moveIcons()
          return
  $scope.init()
