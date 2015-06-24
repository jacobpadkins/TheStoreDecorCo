'use strict'

angular.module 'webappApp'
.controller 'MainCtrl', ($scope) ->

  # cached jQuery variables
  $window = $(window)
  $logo = $('#logo')
  $rowCapa = $('#rowCapa')
  $rowServ = $('#rowServ')
  $rowProd = $('#rowProd')
  $secImg = $('#sectionImage')
  $back = $('#backButton')

  # other variables

  # functions
  clearPage = (which) ->
    # Capabilities
    if which == 0
      $('html, body').animate {scrollTop: 0}, 500, () ->
        $('#slide').animate {'height':'135px'}, 1000
        $('#tagline, #copyText, #divider, #middle, #bottom').fadeOut 1000, () ->
          $('#hideMe').addClass 'hidden'
          $('#middle').addClass('Capabilities').append  '<div class="col-md-1"></div>
                                                                  <div id="list" class="col-md-2"></div>
                                                                  <div id="tiles" class="col-md-8"></div>
                                                                  <div class="col-md-1"></div>'
          $('#middle, #bottom').fadeIn 1000
          $back.fadeIn 1000
    # Products
    else if which == 1
      $('html, body').animate {scrollTop: 0}, 500, () ->
        $('#slide').animate {'height':'135px'}, 1000
        $('#tagline, #copyText, #divider, #middle, #bottom').fadeOut 1000, () ->
          $('#hideMe').addClass 'hidden'
          $('#middle').addClass('Products').append  '<div class="col-md-1"></div>
                                                              <div id="tiles" class="col-md-8"></div>
                                                              <div id="list" class="col-md-2"></div>
                                                              <div class="col-md-1"></div>'
          $('#middle, #bottom').fadeIn 1000
          $back.fadeIn 1000
    # Services
    else if which == 2
      $('html, body').animate {scrollTop: 0}, 500, () ->
        $('#slide').animate {'height':'135px'}, 1000
        $('#tagline, #copyText, #divider, #middle, #bottom').fadeOut 1000, () ->
          $('#hideMe').addClass 'hidden'
          $('#middle').addClass('Services').append  '<div class="col-md-1"></div>
                                                              <div id="list" class="col-md-12"></div>
                                                              <div class="col-md-1"></div>'
          $('#middle, #bottom').fadeIn 1000
          $back.fadeIn 1000

  home = () ->
    $('html, body').animate {scrollTop: 0}, 500, () ->
      $('#slide').animate {'height':'500px'}, 1000
      $('#middle').fadeOut 1000, () ->
        $('#middle').removeClass('Capabilities, Products, Services')
        $('#hideMe').removeClass 'hidden'
        $('#tagline, #copyText, #divider, #middle, #bottom').fadeIn 1000
        $back.fadeOut 1000

  # $(document).ready()
  init = () ->
    # initially hide
    $secImg.fadeOut 0
    $back.fadeOut 0

    # hide/show logo on scroll
    $(window).scroll () ->
      if $window.scrollTop() > 10
        $logo.fadeOut()
      else
        $logo.fadeIn()

    # section image display
    $rowCapa.on 'mouseover', () ->
      # display Capabilities image
      $secImg.css 'background-image', 'url("../../../assets/images/home1.jpg")'
      $secImg.stop().fadeIn 'fast'
    $rowCapa.on 'mouseleave', () ->
      $secImg.fadeOut 0
    $rowProd.on 'mouseover', () ->
      # display Products image
      $secImg.css 'background-image', 'url("../../../assets/images/home2.jpg")'
      $secImg.stop().fadeIn 'fast'
    $rowProd.on 'mouseleave', () ->
      $secImg.fadeOut 0
    $rowServ.on 'mouseover', () ->
      # display Services image
      $secImg.css 'background-image', 'url("../../../assets/images/home3.jpg")'
      $secImg.stop().fadeIn 'fast'
    $rowServ.on 'mouseleave', () ->
      $secImg.fadeOut 0

    # change page on click
    $rowCapa.on 'click', () ->
      clearPage(0);
    $rowProd.on 'click', () ->
      clearPage(1);
    $rowServ.on 'click', () ->
      clearPage(2);

    # return home on button click
    $back.on 'click', () ->
      home();
  init()
