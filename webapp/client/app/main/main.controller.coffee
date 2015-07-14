'use strict'

angular.module 'webappApp'
.controller 'MainCtrl', ($scope) ->

  # cached jQuery variables for often-used handles
  $window = $(window)
  $logo = $('.logo')
  $logoText = $('.logoText')
  $tagline = $('#tagline h1')
  $navHome = $('#navHome')
  $navAbout = $('#navAbout')
  $navContact = $('#navContact')
  $navCapa = $('#navCapa')
  $navProd = $('#navProd')
  $navServ = $('#navServ')
  $allNav = $('#navHome h3, #navAbout h3, #navContact h3, #navCapa h3,
  #navProd h3, #navServ h3')
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
  $socialYT = $('#socialButtons img:nth-of-type(1)')
  $socialTW = $('#socialButtons img:nth-of-type(2)')
  $socialFB = $('#socialButtons img:nth-of-type(3)')
  $socialGP = $('#socialButtons img:nth-of-type(4)')
  $socialLN = $('#socialButtons img:nth-of-type(5)')
  $socialPT = $('#socialButtons img:nth-of-type(6)')
  $socialIG = $('#socialButtons img:nth-of-type(7)')
  $smCapaRow = $('#smCapaRow')
  $smProdRow = $('#smProdRow')
  $smServRow = $('#smServRow')
  $smRowContainer = $('#smRowContainer')
  # and for capa page
  $capaList = $('#capaList')
  $capaTiles = $('#capaTiles')
  # and for prod page
  $prodList = $('#prodList')
  $prodTiles = $('#prodTiles')

  # other variables - main page
  whichPage = 0
  whichSlide = 4
  maxSlide = 9
  # other variables - capa page
  capaCats = ['CNC Cutting & Routing',
              'Custom Packaging',
              'Digital Printing',
              'Foam Sculpture',
              'Metal Fabrication',
              'Millwork & Crafting',
              'Painting',
              'Print Lamination',
              'Prototyping',
              'Specialty Coatings',
              'Thermoforming',
              'Vinyl Graphics']
  capaWhichCate = 13
  # other variables - prod page
  prodCats = ['Dummy1',
              'Dummy2',
              'Dummy3',
              'Dummy4',
              'Dummy5',
              'Dummy6',
              'Dummy7',
              'Dummy8',
              'Dummy9',
              'Dummy10',
              'Dummy11',
              'Dummy12',
              'Dummy13',
              'Dummy14',
              'Dummy15']
  prodWhichCate = 16

  # slideshow timer
  timer = $.timer () ->
    slideShow()
  timer.set {time : 4000, autostart : true}

  # HOME PAGE FUNCTIONS

  clearPage = () ->
    $('#capaPage, #prodPage, #servPage, #abouPage, #contPage').addClass 'hidden'
    # clear capa
    $capaList.empty()
    $capaTiles.empty()
    # clear prod
    $prodList.empty()
    $prodTiles.empty()

  # set navbar highlight to current page
  highlightNavbar = (which) ->
    $allNav.css 'background-color', ''
    if which == 0
      $('#navHome h3').css 'background-color', '#898888'
    else if which == 1
      $('#navCapa h3').css 'background-color', '#898888'
    else if which == 2
      $('#navProd h3').css 'background-color', '#898888'
    else if which == 3
      $('#navServ h3').css 'background-color', '#898888'
    else if which == 4
      $('#navAbout h3').css 'background-color', '#898888'
    else if which == 5
      $('#navContact h3').css 'background-color', '#898888'

  setPage = (which) ->
    popOnce = true
    if whichPage != which
      # set navbar highlight
      highlightNavbar(which)
      # transition from home
      if whichPage == 0
        $('html, body').animate {scrollTop: 0}, 300, () ->
          $('#slide, #slideSM').animate {'height':'135px'}, 500
          $('.copyText, .copyTextM, #copyTextSM1, #copyTextSM, #divider,
          #middle, #bottom').fadeOut 500, () ->
            if $('#tagline:animated, #copyText:animated,
              #copyTextSM:animated, #divider:animated, #middle:animated,
              #bottom:animated').length == 0
              $('#homePage').addClass 'hidden'
              $middle.css 'margin-top', '5px'
              #$middle.css 'background-color', '#1352A5'
              if which == 1
                $middle.css 'height', '800px'
                $('#capaPage').removeClass 'hidden'
                if popOnce == true
                  populateCapa()
                  popOnce = false
              else if which == 2
                $middle.css 'height', '710px'
                $('#prodPage').removeClass 'hidden'
                if popOnce == true
                  populateProd()
                  popOnce = false
              else if which == 3
                $('#servPage').removeClass 'hidden'
              else if which == 4
                $('#abouPage').removeClass 'hidden'
              else if which == 5
                $('#contPage').removeClass 'hidden'
              smMiddleResize()
              $('#middle, #bottom').fadeIn 500
              #$back.fadeIn 300

      # transition from sub-page
      else
        $('html, body').animate {scrollTop: 0}, 300, () ->
          $('#middle, #bottom').fadeOut 300, () ->
            if $('#middle:animated, #bottom:animated').length == 0
              clearPage()
              if which == 1
                $middle.css 'height', '800px'
                $('#capaPage').removeClass 'hidden'
                populateCapa()
              else if which == 2
                $middle.css 'height', '710px'
                $('#prodPage').removeClass 'hidden'
                populateProd()
              else if which == 3
                $('#servPage').removeClass 'hidden'
              else if which == 4
                $('#abouPage').removeClass 'hidden'
              else if which == 5
                $('#contPage').removeClass 'hidden'
              $('#middle, #bottom').fadeIn 300
      whichPage = which

  # transition back to home page
  home = () ->
    if whichPage != 0
      highlightNavbar(0)
      $('html, body').animate {scrollTop: 0}, 300, () ->
        $('#slide, #slideSM').animate {'height':'500px'}, 500
        $('#middle, #bottom').fadeOut 500, () ->
          $middle.css 'margin-top', ''
          $middle.css 'height', '650px'
          #$middle.css 'background-color', '#F1EFE6'
          clearPage()
          $('#homePage').removeClass 'hidden'
          smMiddleResize()
          $('#bottom').css 'background-color', '#D85703'
          $('#social').css 'background-color', '#605F5B'
          $('.copyText, .copyTextM, #copyTextSM1, #copyTextSM,
          #divider, #middle, #bottom').fadeIn 500
          whichPage = 0
          $tagline.text 'Your Brand. Your Vision.'

  # cycle through slideshow
  nextImg = () ->
    if whichSlide < maxSlide
      $img0.attr 'src', '../../../assets/images/home_slideshow/img' +
      (whichSlide + 1) + '.jpg'
      whichSlide++
    else
      $img0.attr 'src', '../../../assets/images/home_slideshow/img1.jpg'
      whichSlide = 1

  slideShow = () ->
      testBool = false
      $img0.animate {'left': '-80%', }, 500, () ->
        $img1.animate {'right': '20%'}, 500, () ->
          $img1.animate {'width': '80%', 'height': '480px'}, 500, () ->
            if $('#img1:animated').length == 0
              $img2.animate {'top': '0'}, 500, () ->
                $img3.animate {'top': '33.33%'}, 500, () ->
                  $img0.fadeOut 0
                  nextImg()
                  $img0.animate {'width': '20%', 'height': '33.33%',
                  'top': '66.66%', 'left': '80%'}, 0, () ->
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

  # resize #middle for mobile layout
  smMiddleResize = () ->
    if whichPage == 0
      if $smRowContainer.css('display') == 'block'
        $middle.css 'height', $smRowContainer.height() + 30
      else
        $middle.css 'height', '650px'

  # CAPA PAGE FUNCTIONS
  populateCapa = () ->
    $capaList.empty()
    # swap colors
    $('#bottom').css 'background-color', '#605F5B'
    $('#social').css 'background-color', '#D85703'
    # add categories
    for category in capaCats
      $capaList.append '<div><h3>' + category + '</h3></div>'

    whichCol = 0
    whichRow = 0
    for category in capaCats
      if whichCol == 0
        $capaTiles.append '<div class="col0" style="top:' + (160 * whichRow) +
        'px;"><h6>' + category + '</h6><img><div>'
        whichCol = 1
      else if whichCol == 1
        $capaTiles.append '<div class="col1" style="top:' + (160 * whichRow) +
        'px;"><h6>' + category + '</h6><img><div>'
        whichCol = 2
      else if whichCol == 2
        $capaTiles.append '<div class="col2" style="top:' + (160 * whichRow) +
        'px;"><h6>' + category + '</h6><img><div>'
        whichCol = 3
      else if whichCol == 3
        $capaTiles.append '<div class="col3" style="top:' + (160 * whichRow) +
        'px;"><h6>' + category + '</h6><img><div>'
        whichCol = 0
        whichRow++

    for i in [1...(capaCats.length+1)]
      $('#capaTiles div:nth-of-type(' + parseInt(i) + ') img').attr 'src', '../../../assets/images/tile_placeholders/img' + parseInt(i) + '.jpg'

    $tagline.text 'Capabilities'

  # PROD PAGE FUNCTIONS
  populateProd = () ->
    $prodList.empty()
    # add categories
    for category in prodCats
      $prodList.append '<div><h3>' + category + '</h3></div>'

    whichCol = 0
    whichRow = 0
    for category in prodCats
      if whichCol == 0
        $prodTiles.append '<div class="col0" style="top:' + (160 * whichRow) +
        'px;"><h6>' + category + '</h6><img><div>'
        whichCol = 1
      else if whichCol == 1
        $prodTiles.append '<div class="col1" style="top:' + (160 * whichRow) +
        'px;"><h6>' + category + '</h6><img><div>'
        whichCol = 2
      else if whichCol == 2
        $prodTiles.append '<div class="col2" style="top:' + (160 * whichRow) +
        'px;"><h6>' + category + '</h6><img><div>'
        whichCol = 3
      else if whichCol == 3
        $prodTiles.append '<div class="col3" style="top:' + (160 * whichRow) +
        'px;"><h6>' + category + '</h6><img><div>'
        whichCol = 0
        whichRow++

    for i in [1...(prodCats.length+1)]
      $('#prodTiles div:nth-of-type(' + parseInt(i) + ') img').attr 'src', '../../../assets/images/tile_placeholders/img' + parseInt(i) + '.jpg'

    $tagline.text 'Products'

  # $(document).ready()
  init = () ->
    # initially hide
    $slideshowBG.fadeOut 0
    $logoText.fadeOut 0

    # highlight home page initially
    highlightNavbar(0)

    ### # # # # # # # # # # # HOME PAGE # # # # # # # # # # # ###
    # start slideshow
    timer.play()

    # hide/show logo on scroll
    $window.scroll () ->
      if $window.scrollTop() > 10
        $logo.fadeOut 'fast'
        $logoText.fadeIn 'fast'
      else
        $logoText.stop().fadeOut 'fast'
        $logo.fadeIn 'fast'

    # navbar listeners
    $logo.on 'click', () ->
      home()
    $logoText.on 'click', () ->
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
      $capaRow.attr 'src', '../../../assets/images/home_slideshow/capabilities-animated.gif'
      $slideshowText.html 'Our collaborative attitude means there\'s nothing
      we can\'t create. Challenge us! Our <span class="underlined">Capabilities
      </span> are unbounded.'
      timer.pause()
      $slideshowBG.stop().fadeIn 300
    $capaRow.on 'mouseleave', () ->
      $capaRow.attr 'src', '../../../assets/images/home_slideshow/capa0.png'
      $slideshowBG.stop().fadeOut 300
      timer.play()
    $capaRow.on 'click', () ->
      setPage(1)


    $prodRow.on 'mouseover', () ->
      $prodRow.attr 'src', '../../../assets/images/home_slideshow/products-animated.gif'
      $slideshowText.html 'We make <span class="underlined">Products</span> that
       set the industry standard for quality, durability and effect!'
      timer.pause()
      $slideshowBG.stop().fadeIn 300
    $prodRow.on 'mouseleave', () ->
      $prodRow.attr 'src', '../../../assets/images/home_slideshow/prod0.png'
      $slideshowBG.stop().fadeOut 300
      timer.play()
    $prodRow.on 'click', () ->
      setPage(2)


    $servRow.on 'mouseover', () ->
      $servRow.attr 'src', '../../../assets/images/home_slideshow/services-animated.gif'
      $slideshowText.html 'We endeavor to understand your needs and eliminate
      your worries. Utilize our <span class="underlined">Services</span> to
      insure your success.'
      timer.pause()
      $slideshowBG.stop().fadeIn 300
    $servRow.on 'mouseleave', () ->
      $servRow.attr 'src', '../../../assets/images/home_slideshow/serv0.png'
      $slideshowBG.stop().fadeOut 300
      timer.play()
    $servRow.on 'click', () ->
      setPage(3)

    # sm and xs row click events
    $smCapaRow.on 'click', () ->
      setPage(1)

    $smProdRow.on 'click', () ->
      setPage(2)

    $smServRow.on 'click', () ->
      setPage(3)

    # small menubar dropdown
    $('#smMenu').on 'click', () ->
      alert 'clicked #smMenu'

    # resize listener
    $window.on 'resize', () ->
      smMiddleResize()

    ### # # # # # # # # # # # CAPA PAGE # # # # # # # # # # # ###

    # tile hover animation
    $capaTiles.on 'mouseover', 'div img', () ->
      $(this).stop().animate {'top':'20%'}, 200
      $(this).css '-webkit-filter', 'grayscale(0%)'
    $capaTiles.on 'mouseleave', 'div img', () ->
      $(this).stop().animate {'top': '0'}, 200
      $(this).css '-webkit-filter', 'grayscale(100%)'

    # sticky categories
    $capaList.on 'click', 'div', () ->
      capaWhichCate = ($(this).index() + 1);
      $('#capaList div h3').not('#capaList div:nth-of-type(' + capaWhichCate + ') h3').css 'color', '#605F5B'
      $('#capaList div h3').not('#capaList div:nth-of-type(' + capaWhichCate + ') h3').stop().animate {'font-size':'12'}, 200

    $capaList.on 'mouseover', 'div', () ->
      $(this).children('h3').stop().animate {'font-size':'15'}, 200
      $(this).children('h3').css 'color', '#1352A5'
      $('#capaTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').stop().animate {'top':'20%'}, 200
      $('#capaTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').css '-webkit-filter', 'grayscale(0%)'
    $capaList.on 'mouseleave', 'div', () ->
      if ($(this).index() + 1) != capaWhichCate
        $(this).children('h3').css 'color', '#605F5B'
        $(this).children('h3').stop().animate {'font-size':'12'}, 200
      $('#capaTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').stop().animate {'top':'0'}, 200
      $('#capaTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').css '-webkit-filter', 'grayscale(100%)'

    ### # # # # # # # # # # # PROD PAGE # # # # # # # # # # # ###

    # tile hover animation
    $prodTiles.on 'mouseover', 'div img', () ->
      $(this).stop().animate {'top':'20%'}, 200
      $(this).css '-webkit-filter', 'grayscale(0%)'
    $prodTiles.on 'mouseleave', 'div img', () ->
      $(this).stop().animate {'top': '0'}, 200
      $(this).css '-webkit-filter', 'grayscale(100%)'

    # sticky categories
    $prodList.on 'click', 'div', () ->
      prodWhichCate = ($(this).index() + 1);
      $('#prodList div h3').not('#prodList div:nth-of-type(' + prodWhichCate + ') h3').css 'color', '#605F5B'
      $('#prodList div h3').not('#prodList div:nth-of-type(' + prodWhichCate + ') h3').stop().animate {'font-size':'12'}, 200

    $prodList.on 'mouseover', 'div', () ->
      $(this).children('h3').stop().animate {'font-size':'15'}, 200
      $(this).children('h3').css 'color', '#1352A5'
      $('#prodTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').stop().animate {'top':'20%'}, 200
      $('#prodTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').css '-webkit-filter', 'grayscale(0%)'
    $prodList.on 'mouseleave', 'div', () ->
      if ($(this).index() + 1) != prodWhichCate
        $(this).children('h3').css 'color', '#605F5B'
        $(this).children('h3').stop().animate {'font-size':'12'}, 200
      $('#prodTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').stop().animate {'top':'0'}, 200
      $('#prodTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').css '-webkit-filter', 'grayscale(100%)'

  init()
