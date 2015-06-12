'use strict'

angular.module 'webappApp'
.controller 'MainCtrl', ($scope, $http) ->
  $scope.awesomeThings = []

  $http.get('/api/things').success (awesomeThings) ->
    $scope.awesomeThings = awesomeThings

  #   NEW STUFF   #

  ### VARIABLES ###
  $scope.whichPage = 0 # 0 = home, 1 = capa., 2 = prod., 3 = serv.
  loopBool = 0
  animBool = 0

  ### FUNCTIONS ###
  moveIcons = () ->
    $('.topOption').fadeIn 'slow'
    $('.row hr').css('margin-top', '0em')
  setPage = () ->
    $('#slideshow').animate {'bottom':'2%'}, 1000, ->
      $('#down').empty().removeClass('container').addClass('container-fluid')
      html = '<div class=\"col-md-2\" id=\"leftList\"></div>'
      $(html).hide().appendTo('#down').fadeIn(1000)
      html = '<div class=\"col-md-10\" id=\"rightList\"></div>'
      $(html).hide().appendTo('#down').fadeIn(1000)
      html = '<p class=\"menu\">Option</p>'
      i = 0
      while i < 40
        $(html).hide().appendTo('#leftList').fadeIn(1000)
        i++
      html = '<div class="row">
                <div id="picCol1" class="col-md-4"></div>
                <div id="picCol2" class="col-md-4"></div>
                <div id="picCol3" class="col-md-4"></div>
              </div>'
      $(html).hide().appendTo('#rightList').fadeIn(1000)
      html = '<div class="pics">Picture Here</div>'
      i = 0
      while i < 4
        $(html).hide().appendTo('#picCol1').fadeIn(1000)
        $(html).hide().appendTo('#picCol2').fadeIn(1000)
        $(html).hide().appendTo('#picCol3').fadeIn(1000)
        i++
  ### $(document).ready() equivalent ###
  $scope.init = () ->
    $('.topOption').fadeOut 0
    $('#logo').on 'click', () ->
      location.reload()
    # switch from home to sub pages
    $('.option').on 'click', ->
      $(this).effect "highlight", {color:'blue'}, 500, ->
        if $(this).text() == 'Capabilities'
          $scope.whichPage = 1
        else if $(this).text() == 'Products'
          $scope.whichPage = 2
        else if $(this).text() == 'Services'
          $scope.whichPage = 3
        $('.option').fadeOut 'slow', ->
          if animBool == 0
            animBool = 1
            moveIcons()
            setPage()
    $('.topOption').on 'click', () ->

    # slide options right
    $('#rightArrow h1').on 'click', () ->
      if loopBool == 0
        $('#wrapper div div').animate {'left':'+=350%'}, 'slow', ->
          #$('#wrapper').empty()
        #loopBool = 1
    #slide options left
    $('#leftArrow h1').on 'click', () ->
      if loopBool == 0
        $('#wrapper div div').animate {'left':'-=350%'}, 'slow'
        #loopBool = 1

  $scope.init()
