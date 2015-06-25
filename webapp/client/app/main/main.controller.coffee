'use strict'

angular.module 'webappApp'
.controller 'MainCtrl', ($scope) ->

  # cached jQuery variables
  $window = $(window)
  $logo = $('#logo')
  $rowCapa = $('#rowCapa')
  $rowProd = $('#rowProd')
  $rowServ = $('#rowServ')
  $secImg = $('#sectionImage')
  $back = $('#backButton h2')

  # other variables

  # functions
  clearPage = (which) ->
    $('html, body').animate {scrollTop: 0}, 500, () ->
      $('#slide').animate {'height':'135px'}, 1000
      $('#tagline, #copyText, #divider, #middle, #bottom').fadeOut 1000, () ->
        $('#homePage').addClass 'hidden'
        $('#middle').css('margin-top', '10px')
        if which == 0
          $('#capaPage').removeClass 'hidden'
        else if which == 1
          $('#prodPage').removeClass 'hidden'
        else if which == 2
          $('#servPage').removeClass 'hidden'
        $('#middle, #bottom').fadeIn 1000
        $back.fadeIn 1000

  home = () ->
    $('html, body').animate {scrollTop: 0}, 500, () ->
      $('#slide').animate {'height':'500px'}, 1000
      $('#middle').fadeOut 1000, () ->
        $('#middle').css('margin-top', '')
        $('#capaPage, #prodPage, #servPage').addClass 'hidden'
        $('#homePage').removeClass 'hidden'
        $('#tagline, #copyText, #divider, #middle, #bottom').fadeIn 1000
        $back.fadeOut 1000

  # $(document).ready()
  init = () ->
    # initially hide
    $secImg.fadeOut 0
    $back.fadeOut 0

    ### # # # # # # # # # # # HOME PAGE # # # # # # # # # # # ###

    # slider
    options = { $AutoPlay: true }
    jssor_slider1 = new $JssorSlider$ 'slider1_container', options

    # hide/show logo on scroll
    $(window).scroll () ->
      if $window.scrollTop() > 10
        $logo.fadeOut()
      else
        $logo.fadeIn()

    # navbar listeners


    # section image display

    $rowCapa.on 'mouseover', () ->
      jssor_slider1.$PlayTo 0, 700
      # display Capabilities image
      #$secImg.css 'background-image', 'url("../../../assets/images/home1.jpg")'
      #$secImg.stop().fadeIn 'fast'
    $rowCapa.on 'mouseleave', () ->
      #$secImg.fadeOut 0

    $rowProd.on 'mouseover', () ->
      jssor_slider1.$PlayTo 1, 700
      # display Products image
      #$secImg.css 'background-image', 'url("../../../assets/images/home2.jpg")'
      #$secImg.stop().fadeIn 'fast'
    $rowProd.on 'mouseleave', () ->
      #$secImg.fadeOut 0

    $rowServ.on 'mouseover', () ->
      jssor_slider1.$PlayTo 2, 700
      # display Services image
      #$secImg.css 'background-image', 'url("../../../assets/images/home3.jpg")'
      #$secImg.stop().fadeIn 'fast'
    $rowServ.on 'mouseleave', () ->
      #$secImg.fadeOut 0

    # change page on click
    $rowCapa.on 'click', () ->
      clearPage(0);
    $rowProd.on 'click', () ->
      clearPage(1);
    $rowServ.on 'click', () ->
      clearPage(2);

    ### # # # # # # # # # # # CAPA PAGE # # # # # # # # # # # ###

    # return home on button click
    $back.on 'click', () ->
      home();
  init()
