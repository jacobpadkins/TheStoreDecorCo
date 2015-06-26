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
  $capaCopy = $('#capaCopy')
  $prodCopy = $('#prodCopy')
  $servCopy = $('#servCopy')
  $middle = $('#middle')

  # other variables
  whichPage = 0
  # functions
  clearPage = () ->
    $('#capaPage, #prodPage, #servPage, #abouPage, #contPage').addClass 'hidden'

  setPage = (which) ->
    if whichPage != which
      # transition from home
      if whichPage == 0
        whichPage = which
        $('html, body').animate {scrollTop: 0}, 500, () ->
          $('#slide').animate {'height':'135px'}, 800
          $('#tagline, #copyText, #divider, #middle, #bottom').fadeOut 800, () ->
            $('#homePage').addClass 'hidden'
            $middle.css 'margin-top', '5px'
            $middle.css 'height', '1000px'
            if which == 1
              $('#capaPage').removeClass 'hidden'
            else if which == 2
              $('#prodPage').removeClass 'hidden'
            else if which == 3
              $('#servPage').removeClass 'hidden'
            else if which == 4
              $('#abouPage').removeClass 'hidden'
            else if which == 5
              $('#contPage').removeClass 'hidden'
            $('#middle, #bottom').fadeIn 800
            $back.fadeIn 800

      # transition from sub-page
      else
        $('html, body').animate {scrollTop: 0}, 500, () ->
          $('#middle, #bottom').fadeOut 500, () ->
            clearPage()
            if which == 1
              $('#capaPage').removeClass 'hidden'
            else if which == 2
              $('#prodPage').removeClass 'hidden'
            else if which == 3
              $('#servPage').removeClass 'hidden'
            else if which == 4
              $('#abouPage').removeClass 'hidden'
            else if which == 5
              $('#contPage').removeClass 'hidden'
            $('#middle, #bottom').fadeIn 500
      whichPage = which

  home = () ->
    if whichPage != 0
      $('html, body').animate {scrollTop: 0}, 500, () ->
        $('#slide').animate {'height':'500px'}, 800
        $('#middle, #bottom').fadeOut 800, () ->
          $middle.css 'margin-top', ''
          $middle.css 'height', '450px'
          $('#capaPage, #prodPage, #servPage, #abouPage, #contPage').addClass 'hidden'
          $('#homePage').removeClass 'hidden'
          $('#tagline, #copyText, #divider, #middle, #bottom').fadeIn 800
          $back.fadeOut 800
          whichPage = 0

  # $(document).ready()
  init = () ->
    # initially hide
    $secImg.fadeOut 0
    $back.fadeOut 0
    $capaCopy.fadeOut 0
    $prodCopy.fadeOut 0
    $servCopy.fadeOut 0

    ### # # # # # # # # # # # HOME PAGE # # # # # # # # # # # ###

    # slider
    options = { $AutoPlay: true }
    jssor_slider1 = new $JssorSlider$ 'slider1_container', options

    # hide/show logo on scroll
    $(window).scroll () ->
      if $window.scrollTop() > 10
        $logo.fadeOut()
      else
        $logo.fadeIn 'fast'

    # navbar listeners
    $logo.on 'click', () ->
      home()
    $navHome.on 'click', () ->
      home()
    $navAbout.on 'click', () ->
      setPage 4
    $navContact.on 'click', () ->
      setPage 5
    $navCapa.on 'click', () ->
      setPage 1
    $navProd.on 'click', () ->
      setPage 2
    $navServ.on 'click', () ->
      setPage 3
    # section image display

    $rowCapa.on 'mouseover', () ->
      jssor_slider1.$PlayTo 0
      $capaCopy.stop().fadeIn 500
    $rowCapa.on 'mouseleave', () ->
      $capaCopy.stop().fadeOut 500

    $rowProd.on 'mouseover', () ->
      jssor_slider1.$PlayTo 1
      $prodCopy.stop().fadeIn 500
    $rowProd.on 'mouseleave', () ->
      $prodCopy.stop().fadeOut 500

    $rowServ.on 'mouseover', () ->
      jssor_slider1.$PlayTo 2
      $servCopy.stop().fadeIn 500
    $rowServ.on 'mouseleave', () ->
      $servCopy.stop().fadeOut 500

    # change page on click
    $rowCapa.on 'click', () ->
      setPage 1
    $rowProd.on 'click', () ->
      setPage 2
    $rowServ.on 'click', () ->
      setPage 3

    ### # # # # # # # # # # # CAPA PAGE # # # # # # # # # # # ###

    # return home on button click
    $back.on 'click', () ->
      home()
  init()
