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
  $capaRow = $('#capaRow img')
  $prodRow = $('#prodRow img')
  $servRow = $('#servRow img')
  $slideshowBG = $('#slideshowText')
  $slideshowText = $('#slideshowText h1')

  # other variables
  whichPage = 0
  whichSlide = 4
  maxSlide = 7
  whichIcon = 1
  animLoopFlag = false

  # slideshow timer
  timer = $.timer () ->
    slideShow()
  timer.set {time : 4000, autostart : true}

  # capa anim timer
  capaTimer = $.timer () ->
    animCapa()
  capaTimer.set {time : 200, autostart : false}

  # prod anim timer
  prodTimer = $.timer () ->
    animProd()
  prodTimer.set {time : 200, autostart : false}

  # serv anim timer
  servTimer = $.timer () ->
    animServ()
  servTimer.set {time : 200, autostart : false}

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

  # capabilities icon animation functions
  animCapa = () ->
    if whichIcon < 5
      $capaRow.attr 'src', '../../../assets/images/home_slideshow/capa' + whichIcon + '.png'
      whichIcon++
    else
      $capaRow.attr 'src', '../../../assets/images/home_slideshow/capa1.png'
      whichIcon = 1

  # products icon animation functions
  animProd = () ->
    if animLoopFlag == false
      if whichIcon < 3
        $prodRow.attr 'src', '../../../assets/images/home_slideshow/prod' + whichIcon + '.png'
        whichIcon += 1
      else
        $prodRow.attr 'src', '../../../assets/images/home_slideshow/prod3.png'
        whichIcon = 2
        animLoopFlag = true
    else
      if whichIcon > 1
        $prodRow.attr 'src', '../../../assets/images/home_slideshow/prod' + whichIcon + '.png'
        whichIcon -= 1
      else
        $prodRow.attr 'src', '../../../assets/images/home_slideshow/prod1.png'
        whichIcon = 2
        animLoopFlag = false

  # services icon animation functions
  animServ = () ->
    if animLoopFlag == false
      if whichIcon < 4
        $servRow.attr 'src', '../../../assets/images/home_slideshow/serv' + whichIcon + '.png'
        whichIcon += 1
      else
        $servRow.attr 'src', '../../../assets/images/home_slideshow/serv4.png'
        whichIcon = 2
        animLoopFlag = true
    else
      if whichIcon > 1
        $servRow.attr 'src', '../../../assets/images/home_slideshow/serv' + whichIcon + '.png'
        whichIcon -= 1
      else
        $servRow.attr 'src', '../../../assets/images/home_slideshow/serv1.png'
        whichIcon = 2
        animLoopFlag = false

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
      $prodRow.attr 'src', '../../../assets/images/home_slideshow/prod1.png'
      prodTimer.play()
      animProd()
      $slideshowText.text 'We make Products that set the industry standard for quality, durability and effect!'
      timer.pause()
      $slideshowBG.stop().fadeIn 300
    $prodRow.on 'mouseleave', () ->
      prodTimer.pause()
      $prodRow.attr 'src', '../../../assets/images/home_slideshow/prod0.png'
      whichIcon = 1
      animLoopFlag = false
      $slideshowBG.stop().fadeOut 300
      timer.play()


    $servRow.on 'mouseover', () ->
      $servRow.attr 'src', '../../../assets/images/home_slideshow/serv1.png'
      servTimer.play()
      animServ()
      $slideshowText.text 'We endeavor to understand your needs and eliminate your worries. Utilize our Services to insure your success.'
      timer.pause()
      $slideshowBG.stop().fadeIn 300
    $servRow.on 'mouseleave', () ->
      servTimer.pause()
      $servRow.attr 'src', '../../../assets/images/home_slideshow/serv0.png'
      whichIcon = 1
      animLoopFlag = false
      $slideshowBG.stop().fadeOut 300
      timer.play()

    ### # # # # # # # # # # # CAPA PAGE # # # # # # # # # # # ###

    # return home on button click
    $back.on 'click', () ->
      home()
  init()
