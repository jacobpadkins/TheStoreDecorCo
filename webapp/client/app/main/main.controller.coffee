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
  $capaRow = $('#capaRow')
  $prodRow = $('#prodRow')
  $servRow = $('#servRow')
  $slideshowBG = $('#slideshowText')
  $slideshowText = $('#slideshowText h1')

  # other variables
  whichPage = 0
  whichSlide = 4
  maxSlide = 7

  # slideshow timer
  timer = $.timer () ->
    slideShow()
  timer.set {time : 4000, autostart : true}

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
  nextImg = () ->
    if whichSlide < maxSlide
      $img0.attr 'src', '../../../assets/images/home_slideshow/img' + (whichSlide + 1) + '.jpg'
      whichSlide++
    else
      $img0.attr 'src', '../../../assets/images/home_slideshow/img1.jpg'
      whichSlide = 1


  slideShow = () ->
      testBool = false
      $img0.animate {'left': '-80%', }, 500, () ->
        $img1.animate {'right': '20%'}, 500, () ->
          $img1.animate {'width': '80%', 'height': '400px'}, 500, () ->
            if $('#img1:animated').length == 0
              $img2.animate {'top': '0'}, 500, () ->
                $img3.animate {'top': '33.33%'}, 500, () ->
                  $img0.fadeOut 0
                  nextImg()
                  $img0.animate {'width': '20%', 'height': '133.33px', 'top': '66.66%', 'left': '80%'}, 0, () ->
                    $img0.fadeIn 500, () ->
                      resetSlideIds()

  resetSlideIds = () ->
    $img0.attr 'id', 'img3'
    $img1.attr 'id', 'img0'
    $img2.attr 'id', 'img1'
    $img3.attr 'id', 'img2'
    $img0 = $('#img0')
    $img1 = $('#img1')
    $img2 = $('#img2')
    $img3 = $('#img3')
    $allImgs = $('#img0, #img1, #img2, #img3')
    $allImgs.removeAttr('style')

  # $(document).ready()
  init = () ->
    # initially hide
    $back.fadeOut 0
    $slideshowBG.fadeOut 0

    ### # # # # # # # # # # # HOME PAGE # # # # # # # # # # # ###
    # start slideshow
    timer.play()

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

    # slideshow buttons hover events
    $capaRow.on 'mouseover', () ->
      $slideshowText.text 'Our collaborative attitude means there\'s nothing we can\'t create. Challenge us! Our Capabilities are unbounded.'
      timer.pause()
      $slideshowBG.stop().fadeIn 300
    $capaRow.on 'mouseleave', () ->
      $slideshowBG.stop().fadeOut 300
      timer.play()
    $prodRow.on 'mouseover', () ->
      $slideshowText.text 'We make Products that set the industry standard for quality, durability and effect!'
      timer.pause()
      $slideshowBG.stop().fadeIn 300
    $prodRow.on 'mouseleave', () ->
      $slideshowBG.stop().fadeOut 300
      timer.play()
    $servRow.on 'mouseover', () ->
      $slideshowText.text 'We endeavor to understand your needs and eliminate your worries. Utilize our Services to insure your success.'
      timer.pause()
      $slideshowBG.stop().fadeIn 300
    $servRow.on 'mouseleave', () ->
      $slideshowBG.stop().fadeOut 300
      timer.play()

    ### # # # # # # # # # # # CAPA PAGE # # # # # # # # # # # ###

    # return home on button click
    $back.on 'click', () ->
      home()
  init()
