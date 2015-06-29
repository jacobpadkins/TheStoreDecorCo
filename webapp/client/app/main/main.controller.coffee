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
  $img0 = $('#img0')
  $img1 = $('#img1')
  $img2 = $('#img2')
  $img3 = $('#img3')
  $allImgs = $('#img0, #img1, #img2, #img3')

  # other variables
  whichPage = 0
  whichSlide = 0
  maxSlide = 7
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

  # transition back to home page
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

  # cycle through slideshow
  slideShow = () ->
    $allImgs.stop().fadeOut 1000, () ->
      if $('#img0:animated, #img1:animated, #img2:animated, #img3:animated').length == 0
        # switch pics
        if whichSlide <= maxSlide - 4
          $img0.attr 'src', '../../../assets/images/home_slideshow/img' + (whichSlide + 1) + '.jpg'
          $img1.attr 'src', '../../../assets/images/home_slideshow/img' + (whichSlide + 2) + '.jpg'
          $img2.attr 'src', '../../../assets/images/home_slideshow/img' + (whichSlide + 3) + '.jpg'
          $img3.attr 'src', '../../../assets/images/home_slideshow/img' + (whichSlide + 4) + '.jpg'
          whichSlide += 1
        else if whichSlide == maxSlide - 3
          $img0.attr 'src', '../../../assets/images/home_slideshow/img' + (whichSlide + 1) + '.jpg'
          $img1.attr 'src', '../../../assets/images/home_slideshow/img' + (whichSlide + 2) + '.jpg'
          $img2.attr 'src', '../../../assets/images/home_slideshow/img' + (whichSlide + 3) + '.jpg'
          $img3.attr 'src', '../../../assets/images/home_slideshow/img' + 1 + '.jpg'
          whichSlide += 1
        else if whichSlide == maxSlide - 2
          $img0.attr 'src', '../../../assets/images/home_slideshow/img' + (whichSlide + 1) + '.jpg'
          $img1.attr 'src', '../../../assets/images/home_slideshow/img' + (whichSlide + 2) + '.jpg'
          $img2.attr 'src', '../../../assets/images/home_slideshow/img' + 1 + '.jpg'
          $img3.attr 'src', '../../../assets/images/home_slideshow/img' + 2 + '.jpg'
          whichSlide += 1
        else if whichSlide == maxSlide - 1
          $img0.attr 'src', '../../../assets/images/home_slideshow/img' + (whichSlide + 1) + '.jpg'
          $img1.attr 'src', '../../../assets/images/home_slideshow/img' + 1 + '.jpg'
          $img2.attr 'src', '../../../assets/images/home_slideshow/img' + 2 + '.jpg'
          $img3.attr 'src', '../../../assets/images/home_slideshow/img' + 3 + '.jpg'
          whichSlide += 1
        else if whichSlide == maxSlide
          $img0.attr 'src', '../../../assets/images/home_slideshow/img' + 1 + '.jpg'
          $img1.attr 'src', '../../../assets/images/home_slideshow/img' + 2 + '.jpg'
          $img2.attr 'src', '../../../assets/images/home_slideshow/img' + 3 + '.jpg'
          $img3.attr 'src', '../../../assets/images/home_slideshow/img' + 4 + '.jpg'
          whichSlide = 0
        $allImgs.stop().fadeIn 1000

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

    # slideshow
    slideShow()
    window.setInterval slideShow, 5000

    ### # # # # # # # # # # # CAPA PAGE # # # # # # # # # # # ###

    # return home on button click
    $back.on 'click', () ->
      home()
  init()
