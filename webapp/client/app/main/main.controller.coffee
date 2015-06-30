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
  $socialYT = $('#socialButtons img:nth-of-type(1)')
  $socialTW = $('#socialButtons img:nth-of-type(2)')
  $socialPT = $('#socialButtons img:nth-of-type(3)')
  $socialFB = $('#socialButtons img:nth-of-type(4)')
  $socialGP = $('#socialButtons img:nth-of-type(5)')
  $socialLN = $('#socialButtons img:nth-of-type(6)')
  $socialIG = $('#socialButtons img:nth-of-type(7)')

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
    if animLoopFlag == false
      if whichIcon < 5
        $capaRow.attr 'src', '../../../assets/images/home_slideshow/capa' + whichIcon + '.png'
        whichIcon += 1
      else
        $capaRow.attr 'src', '../../../assets/images/home_slideshow/capa5.png'
        whichIcon = 4
        animLoopFlag = true
    else
      if whichIcon > 1
        $capaRow.attr 'src', '../../../assets/images/home_slideshow/capa' + whichIcon + '.png'
        whichIcon -= 1
      else
        $capaRow.attr 'src', '../../../assets/images/home_slideshow/capa1.png'
        whichIcon = 2
        animLoopFlag = false

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

    if whichIcon < 4
      $servRow.attr 'src', '../../../assets/images/home_slideshow/serv' + whichIcon + '.png'
      whichIcon += 1
      if whichIcon == 4
        whichIcon = 1

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
      $capaRow.attr 'src', '../../../assets/images/home_slideshow/capa1.png'
      capaTimer.play()
      animCapa()
      $slideshowText.html 'Our collaborative attitude means there\'s nothing we can\'t create. Challenge us! Our <span class="underlined">Capabilities</span> are unbounded.'
      timer.pause()
      $slideshowBG.stop().fadeIn 300
    $capaRow.on 'mouseleave', () ->
      capaTimer.pause()
      $capaRow.attr 'src', '../../../assets/images/home_slideshow/capa0.png'
      whichIcon = 1
      animLoopFlag = false
      $slideshowBG.stop().fadeOut 300
      timer.play()
    $capaRow.on 'click', () ->
      setPage(1)


    $prodRow.on 'mouseover', () ->
      $prodRow.attr 'src', '../../../assets/images/home_slideshow/prod1.png'
      prodTimer.play()
      animProd()
      $slideshowText.html 'We make <span class="underlined">Products</span> that set the industry standard for quality, durability and effect!'
      timer.pause()
      $slideshowBG.stop().fadeIn 300
    $prodRow.on 'mouseleave', () ->
      prodTimer.pause()
      $prodRow.attr 'src', '../../../assets/images/home_slideshow/prod0.png'
      whichIcon = 1
      animLoopFlag = false
      $slideshowBG.stop().fadeOut 300
      timer.play()
    $prodRow.on 'click', () ->
      setPage(2)


    $servRow.on 'mouseover', () ->
      $servRow.attr 'src', '../../../assets/images/home_slideshow/serv1.png'
      servTimer.play()
      animServ()
      $slideshowText.html 'We endeavor to understand your needs and eliminate your worries. Utilize our <span class="underlined">Services</span> to insure your success.'
      timer.pause()
      $slideshowBG.stop().fadeIn 300
    $servRow.on 'mouseleave', () ->
      servTimer.pause()
      $servRow.attr 'src', '../../../assets/images/home_slideshow/serv0.png'
      whichIcon = 1
      animLoopFlag = false
      $slideshowBG.stop().fadeOut 300
      timer.play()
    $servRow.on 'click', () ->
      setPage(3)

    # social media buttons
    $socialYT.on 'mouseover', () ->
      $socialYT.attr 'src', '../../../assets/images/social/social_yt1.svg'
    $socialYT.on 'mouseleave', () ->
      $socialYT.attr 'src', '../../../assets/images/social/social_yt0.svg'

    $socialTW.on 'mouseover', () ->
      $socialTW.attr 'src', '../../../assets/images/social/social_tw1.svg'
    $socialTW.on 'mouseleave', () ->
      $socialTW.attr 'src', '../../../assets/images/social/social_tw0.svg'

    $socialFB.on 'mouseover', () ->
      $socialFB.attr 'src', '../../../assets/images/social/social_fb1.svg'
    $socialFB.on 'mouseleave', () ->
      $socialFB.attr 'src', '../../../assets/images/social/social_fb0.svg'

    $socialGP.on 'mouseover', () ->
      $socialGP.attr 'src', '../../../assets/images/social/social_gp1.svg'
    $socialGP.on 'mouseleave', () ->
      $socialGP.attr 'src', '../../../assets/images/social/social_gp0.svg'

    $socialLN.on 'mouseover', () ->
      $socialLN.attr 'src', '../../../assets/images/social/social_ln1.svg'
    $socialLN.on 'mouseleave', () ->
      $socialLN.attr 'src', '../../../assets/images/social/social_ln0.svg'

    $socialPT.on 'mouseover', () ->
      $socialPT.attr 'src', '../../../assets/images/social/social_pt1.svg'
    $socialPT.on 'mouseleave', () ->
      $socialPT.attr 'src', '../../../assets/images/social/social_pt0.svg'

    $socialIG.on 'mouseover', () ->
      $socialIG.attr 'src', '../../../assets/images/social/social_ig1.svg'
    $socialIG.on 'mouseleave', () ->
      $socialIG.attr 'src', '../../../assets/images/social/social_ig0.svg'

    ### # # # # # # # # # # # CAPA PAGE # # # # # # # # # # # ###

    # return home on button click
    $back.on 'click', () ->
      home()

  init()
