'use strict'

angular.module 'webappApp'
.controller 'MainCtrl', ($scope) ->

  # cached jQuery variables
  $window = $(window)
  $logo = $('.logo')
  $back = $('.backButton h2')
  $navHome = $('#navHome')
  $navAbout = $('#navAbout')
  $navContact = $('#navContact')
  $navCapa = $('#navCapa')
  $navProd = $('#navProd')
  $navServ = $('#navServ')
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
        $('html, body').animate {scrollTop: 0}, 500, () ->
          $('#slide').animate {'height':'135px'}, 800
          $('#tagline, #taglineSM, #copyText, #copyTextSM, #divider, #middle, #bottom').fadeOut 800, () ->
            if $('#tagline:animated, #taglineSM:animated, #copyText:animated, #copyTextSM:animated, #divider:animated, #middle:animated, #bottom:animated').length == 0
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
            if $('#middle:animated, #bottom:animated').length == 0
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
          clearPage()
          $('#homePage').removeClass 'hidden'
          $('#tagline, #copyText, #copyTextSM, #divider, #middle, #bottom').fadeIn 800
          $back.fadeOut 800
          whichPage = 0

  # $(document).ready()
  init = () ->
    # initially hide
    $back.fadeOut 0

    ### # # # # # # # # # # # HOME PAGE # # # # # # # # # # # ###

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

    ### # # # # # # # # # # # CAPA PAGE # # # # # # # # # # # ###

    # return home on button click
    $back.on 'click', () ->
      home()
  init()
