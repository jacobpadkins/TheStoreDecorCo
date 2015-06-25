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
  $navHome = $('#navHome')
  $navAbout = $('#navAbout')
  $navContact = $('#navContact')
  $navCapa = $('#navCapa')
  $navProd = $('#navProd')
  $navServ = $('#navServ')

  # other variables
  onHome = true
  # functions
  clearPage = () ->
    $('#capaPage, #prodPage, #servPage, #abouPage, #contPage').addClass 'hidden'

  setPage = (which) ->
    # transition from home
    if onHome == true
      onHome = false
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
          else if which == 3
            $('#abouPage').removeClass 'hidden'
          else if which == 4
            $('#contPage').removeClass 'hidden'
          $('#middle, #bottom').fadeIn 1000
          $back.fadeIn 1000

    # transition from sub-page
    else
      $('html, body').animate {scrollTop: 0}, 500, () ->
        $('#middle, #bottom').fadeOut 1000, () ->
          $('#middle').css('margin-top', '10px')
          clearPage()
          if which == 0
            $('#capaPage').removeClass 'hidden'
          else if which == 1
            $('#prodPage').removeClass 'hidden'
          else if which == 2
            $('#servPage').removeClass 'hidden'
          else if which == 3
            $('#abouPage').removeClass 'hidden'
          else if which == 4
            $('#contPage').removeClass 'hidden'
          $('#middle, #bottom').fadeIn 1000

  home = () ->
    $('html, body').animate {scrollTop: 0}, 500, () ->
      $('#slide').animate {'height':'500px'}, 1000
      $('#middle, #bottom').fadeOut 1000, () ->
        $('#middle').css('margin-top', '')
        $('#capaPage, #prodPage, #servPage, #abouPage, #contPage').addClass 'hidden'
        $('#homePage').removeClass 'hidden'
        $('#tagline, #copyText, #divider, #middle, #bottom').fadeIn 1000
        $back.fadeOut 1000
        onHome = true

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
    $navHome.on 'click', () ->
      home()
    $navAbout.on 'click', () ->
      setPage 3
    $navContact.on 'click', () ->
      setPage 4
    $navCapa.on 'click', () ->
      setPage 0
    $navProd.on 'click', () ->
      setPage 1
    $navServ.on 'click', () ->
      setPage 2
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
      setPage 0
    $rowProd.on 'click', () ->
      setPage 1
    $rowServ.on 'click', () ->
      setPage 2

    ### # # # # # # # # # # # CAPA PAGE # # # # # # # # # # # ###

    # return home on button click
    $back.on 'click', () ->
      home()
  init()
