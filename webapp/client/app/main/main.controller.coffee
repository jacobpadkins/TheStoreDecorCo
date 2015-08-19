'use strict'

angular.module 'webappApp'
.controller 'MainCtrl', ($scope, $http) ->

  # cached jQuery variables for often-used handles
  $window = $(window)
  $logo = $('.logo')
  $bubbleDiv = $('#bubbleDiv')
  $slidemenu = $('#slidemenu')
  $slideHome = $('#slideHome')
  $slideCapa = $('#slideCapa')
  $slideProd = $('#slideProd')
  $slideServ = $('#slideServ')
  $slideAbou = $('#slideAbou')
  $slideCont = $('#slideCont')
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
  $smAbouRow = $('#smAbouRow')
  $smContRow = $('#smContRow')
  $smRowContainer = $('#smRowContainer')
  # and for capa page
  $capaList = $('#capaList')
  $capaTiles = $('.capaTiles')
  # and for prod page
  $prodList = $('#prodList')
  $prodTiles = $('.prodTiles')
  # and for serv page
  $servResponse = $('#servPage .col-md-12:nth-of-type(5) .col-md-8,
                     #servPage .col-md-12:nth-of-type(6) .col-md-8,
                     #servPage .col-md-12:nth-of-type(7) .col-md-8,
                     #servPage .col-md-12:nth-of-type(8) .col-md-8')

  # other variables - main page
  slidemenuShown = false
  whichPage = 0
  whichSlide = 4
  whichMainSlide = 1
  mainSlidePics = []
  smallSlidePics = []
  mainSlideTaglines = ['YOUR BRAND. YOUR VISION.',
                       'BRAND ELOQUENCE.',
                       'IMMERSIVE STORE EXPERIENCES.',
                       'DESTINATION DECOR.']
  # other variables - capa page
  capaCats = []
  capaWhichCate = 13
  # other variables - prod page
  prodCats = []
  prodWhichCate = 16

  # color/bw pics arrays
  colorPics = {}
  bwPics = {}

  # slideshow timer
  timer = $.timer () ->
    slideShow()
  timer.set {time : 4000, autostart : true}

  timer_main = $.timer () ->
    swapMainSlide()
  timer_main.set {time: 8000, autostart: true}

  database = () ->
    $http({
      url: 'api/cms/images/website',
      method: 'GET',
    }).success (response) ->
      # populate categories
      capaCats = response.capas
      prodCats = response.prods
      # populate small and main slideshows & populate hidden lightbox anchors
      i = 0
      while i < response.imgs.length
        index = $.inArray('Small_Slide', response.imgs[i].Flags)
        if  index != -1
          smallSlidePics.push(response.imgs[i].filename)
          response.imgs[i].Flags.splice(index, 1)
        index = $.inArray('Big_Slide', response.imgs[i].Flags)
        if  index != -1
          mainSlidePics.push(response.imgs[i].filename)
          response.imgs[i].Flags.splice(index, 1)
        j = 0
        while j < response.imgs[i].Capabilities.length
          lightbox_str = 'lightbox[' + response.imgs[i].Capabilities[j] + ']'
          $(wrapper).append '<a href="../../../assets/images/uploads/' + response.imgs[i].filename + '" rel="' + lightbox_str + '"></a>'
          j++
        j = 0
        while j < response.imgs[i].Products.length
          lightbox_str = 'lightbox[' + response.imgs[i].Products[j] + ']'
          $(wrapper).append '<a href="../../../assets/images/uploads/' + response.imgs[i].filename + '" rel="' + lightbox_str + '"></a>'
          j++
        j = 0
        while j < response.imgs[i].Flags.length
          flag_obj = JSON.parse(response.imgs[i].Flags[j])
          if flag_obj["rep_color"] != undefined
            colorPics[flag_obj["rep_color"]] = response.imgs[i].filename
          if flag_obj["rep_bw"] != undefined
            bwPics[flag_obj["rep_bw"]] = response.imgs[i].filename
          j++
        i++
      $img0.attr 'src', '../../../assets/images/uploads/' + smallSlidePics[0]
      $img1.attr 'src', '../../../assets/images/uploads/' + smallSlidePics[1]
      $img2.attr 'src', '../../../assets/images/uploads/' + smallSlidePics[2]
      $img3.attr 'src', '../../../assets/images/uploads/' + smallSlidePics[3]

      $('#slide, #slideSM').css 'background-image', 'url(../../../assets/images/uploads/' + mainSlidePics[0] + ')'
      i = 1
      while i < mainSlidePics.length
        $bubbleDiv.append '<img class="bubble" src="../../../assets/images/home_slideshow/dot_empty.png">'
        i++
      # set category length var
      capaWhichCate = response.capas.length + 1
      prodWhichCate = response.prods.length + 1

  # HOME PAGE FUNCTIONS

  swapMainSlide = () ->
    $('.bubble').attr 'src', '../../../assets/images/home_slideshow/dot_empty.png'
    $('#bubbleDiv img:nth-of-type(' + (whichMainSlide+1) + ')').attr 'src', '../../../assets/images/home_slideshow/dot_full.png'
    $('#slide, #slideSM #tagline').stop().fadeOut 500, () ->
        $('#slide, #slideSM').css 'background-image', 'url(../../../assets/images/uploads/' + mainSlidePics[whichMainSlide] + ')'
        $('#tagline h1').text mainSlideTaglines[whichMainSlide]
        if whichMainSlide < mainSlidePics.length - 1
          whichMainSlide += 1
        else
          whichMainSlide = 0
      $('#slide, #slideSM #tagline').fadeIn 500, () ->

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
      timer.stop()
      timer_main.stop()
      # set navbar highlight
      highlightNavbar(which)
      # transition from home
      if whichPage == 0
        $('html, body').animate {scrollTop: 0}, 300, () ->
          $('#slide, #slideSM').animate {'height':'135px'}, 500
          $('#tagline, #bubbleDiv, .copyText, .copyTextM, #copyTextSM1, #copyTextSM, #divider,
          #middle, #bottom').fadeOut 500, () ->
            if $('#tagline:animated, #copyText:animated,
              #copyTextSM:animated, #divider:animated, #middle:animated,
              #bottom:animated').length == 0
              $('#homePage').addClass 'hidden'
              $middle.css 'margin-top', '5px'
              $('#bottom').css 'background-color', '#605F5B'
              $('#social').css 'background-color', '#D85703'
              $('#socialDiv').removeClass 'hidden'
              if which == 1
                $('#capaPage').removeClass 'hidden'
                if popOnce == true
                  populateCapa()
                  popOnce = false
              else if which == 2
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
              $('#middle, #bottom').fadeIn 500
              middleResize(which)
              #$back.fadeIn 300

      # transition from sub-page
      else
        $('html, body').animate {scrollTop: 0}, 300, () ->
          $('#middle, #bottom').fadeOut 300, () ->
            if $('#middle:animated, #bottom:animated').length == 0
              clearPage()
              $('#socialDiv').removeClass 'hidden'
              middleResize(which)
              if which == 1
                $('#capaPage').removeClass 'hidden'
                populateCapa()
              else if which == 2
                $('#prodPage').removeClass 'hidden'
                populateProd()
              else if which == 3
                $('#servPage').removeClass 'hidden'
              else if which == 4
                $('#abouPage').removeClass 'hidden'
              else if which == 5
                $('#contPage').removeClass 'hidden'
              $('#middle, #bottom').fadeIn 300
              middleResize(which)
      whichPage = which

  # transition back to home page
  home = () ->
    if whichPage != 0
      timer.play()
      timer_main.play()
      highlightNavbar(0)
      $('html, body').animate {scrollTop: 0}, 300, () ->
        $('#slide').animate {'height':'500px'}, 500
        $('#slideSM').animate {'height':'250px'}, 500
        $('#middle, #bottom').fadeOut 500, () ->
          $middle.css 'margin-top', ''
          middleResize(0)
          #$middle.css 'background-color', '#F1EFE6'
          clearPage()
          $('#homePage').removeClass 'hidden'
          $('#bottom').css 'background-color', '#D85703'
          $('#social').css 'background-color', '#605F5B'
          $('#socialDiv').addClass 'hidden'
          $('#tagline, #bubbleDiv, .copyText, .copyTextM, #copyTextSM1, #copyTextSM,
          #divider, #middle, #bottom').fadeIn 500
          whichPage = 0
          $tagline.text 'Your Brand. Your Vision.'

  # cycle through slideshow
  nextImg = () ->
    if whichSlide < smallSlidePics.length
      $img0.attr 'src', '../../../assets/images/uploads/' + smallSlidePics[whichSlide]
      whichSlide++
    else
      $img0.attr 'src', '../../../assets/images/uploads/' + smallSlidePics[0]
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
  middleResize = (which) ->
    # xs
    if $(window).width() < 768
      if which == 0
        $middle.css 'height', '430px'
      else if which == 1
        $middle.css 'height', (capaCats.length / 2)*250
        $('#capaCopy').css 'top', (capaCats.length / 2)*200
      else if which == 2
        $middle.css 'height', (prodCats.length / 2)*250
        $('#prodCopy').css 'top', (prodCats.length / 2)*200
      else if which == 3
        $middle.css 'height', '4030px'
        $servResponse.addClass('.col-md-8').removeClass 'col-md-12'
        $servResponse.addClass('.col-md-12').removeClass 'col-md-8'
      else if which == 4
        $middle.css('height', $('#aboutContainer').height() + 60)
      else if which == 5
        $middle.css 'height', '580px'
      # resize slidemenu
      $slidemenu.height($(window).height())
    # sm
    else if $(window).width() >= 768 and $(window).width() <= 992
      if which == 0
        $middle.css 'height', '405px'
      else if which == 1
        $middle.css 'height', (capaCats.length / 2)*250
        $('#capaCopy').css 'top', (capaCats.length / 2)*200
      else if which == 2
        $middle.css 'height', (prodCats.length / 2)*250
        $('#prodCopy').css 'top', (prodCats.length / 2)*200
      else if which == 3
        $middle.css 'height', '2590px'
        $servResponse.addClass('.col-md-8').removeClass 'col-md-12'
        $servResponse.addClass('.col-md-12').removeClass 'col-md-8'
      else if which == 4
        $middle.css('height', $('#aboutContainer').height() + 60)
      else if which == 5
        $middle.css 'height', '580px'
      # resize slidemenu
      $slidemenu.height($(window).height())
    # md
    else if $(window).width() > 992 and $(window).width() <= 1200
      if which == 0
        $middle.css 'height', '650px'
      else if which == 1
        $middle.css 'height', (capaCats.length / 4)*250
        $('#capaCopy').css 'top', (capaCats.length / 4)*200
      else if which == 2
        $middle.css 'height', (prodCats.length / 4)*250
        $('#prodCopy').css 'top', (prodCats.length / 4)*200
      else if which == 3
        $middle.css 'height', '2230px'
        $servResponse.addClass('.col-md-12').removeClass 'col-md-8'
        $servResponse.addClass('.col-md-8').removeClass 'col-md-12'
      else if which == 4
        $middle.css('height', $('#aboutContainer').height() + 60)
      else if which == 5
        $middle.css 'height', '580px'
    # lg
    else
      if which == 0
        $middle.css 'height', '650px'
      else if which == 1
        $middle.css 'height', (capaCats.length / 4)*250
        $('#capaCopy').css 'top', (capaCats.length / 4)*200
      else if which == 2
        $middle.css 'height', (prodCats.length / 4)*250
        $('#prodCopy').css 'top', ((prodCats.length / 4)*200)
      else if which == 3
        $middle.css 'height', '1750px'
        $servResponse.addClass('.col-md-12').removeClass 'col-md-8'
        $servResponse.addClass('.col-md-8').removeClass 'col-md-12'
      else if which == 4
        $middle.css('height', $('#aboutContainer').height() + 60)
      else if which == 5
        $middle.css 'height', '580px'

  # CAPA PAGE FUNCTIONS
  populateCapa = () ->
    $capaList.empty()
    # add categories
    for category in capaCats
      $capaList.append '<div><h3>' + category + '</h3></div>'

    whichCol = 0
    whichRow = 0
    for category in capaCats
      if whichCol == 0
        $capaTiles.append '<div class="col0" style="top:' + (160 * whichRow) +
        'px;"><a href="">' + category + '</a><img><div>'
        whichCol = 1
      else if whichCol == 1
        $capaTiles.append '<div class="col1" style="top:' + (160 * whichRow) +
        'px;"><a href="">' + category + '</a><img><div>'
        whichCol = 2
      else if whichCol == 2
        $capaTiles.append '<div class="col2" style="top:' + (160 * whichRow) +
        'px;"><a href="">' + category + '</a><img><div>'
        whichCol = 3
      else if whichCol == 3
        $capaTiles.append '<div class="col3" style="top:' + (160 * whichRow) +
        'px;"><a href="">' + category + '</a><img><div>'
        whichCol = 0
        whichRow++

    for i in [1...(capaCats.length+1)]
      bw_image = $('#capaList div:nth-of-type(' + parseInt(i) + ') h3').text()
      $('.capaTiles div:nth-of-type(' + parseInt(i) + ') img').attr('src', '../../../assets/images/uploads/' + bwPics[bw_image])

  # PROD PAGE FUNCTIONS
  populateProd = () ->
    console.log prodCats
    $prodList.empty()
    # add categories
    for category in prodCats
      console.log category
      $prodList.append '<div><h3>' + category + '</h3></div>'

    whichCol = 0
    whichRow = 0
    for category in prodCats
      if whichCol == 0
        $prodTiles.append '<div class="col0" style="top:' + (160 * whichRow) +
        'px;"><a href="" rel="lightbox[' + category + ']">' + category + '</a><img><div>'
        whichCol = 1
      else if whichCol == 1
        $prodTiles.append '<div class="col1" style="top:' + (160 * whichRow) +
        'px;"><a href="" rel="lightbox[' + category + ']">' + category + '</a><img><div>'
        whichCol = 2
      else if whichCol == 2
        $prodTiles.append '<div class="col2" style="top:' + (160 * whichRow) +
        'px;"><a href="" rel="lightbox[' + category + ']">' + category + '</a><img><div>'
        whichCol = 3
      else if whichCol == 3
        $prodTiles.append '<div class="col3" style="top:' + (160 * whichRow) +
        'px;"><a href="" rel="lightbox[' + category + ']">' + category + '</a><img><div>'
        whichCol = 0
        whichRow++

    for i in [1...(prodCats.length+1)]
      bw_image = $('#prodList div:nth-of-type(' + parseInt(i) + ') h3').text()
      $('.prodTiles div:nth-of-type(' + parseInt(i) + ') img').attr('src', '../../../assets/images/uploads/' + bwPics[bw_image])

  # $(document).ready()
  init = () ->
    # pull info from database & populate images
    database()

    # initially hide
    $slideshowBG.fadeOut 0

    # resize #middle
    middleResize(whichPage)

    # highlight home page initially
    highlightNavbar(0)

    ### # # # # # # # # # # # HOME PAGE # # # # # # # # # # # ###
    # start slideshow
    timer.play()
    timer_main.play()

    # hide/show logo on scroll
    $window.scroll () ->
      if $window.scrollTop() > 10
        $logo.fadeOut 'fast'
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

    $smAbouRow.on 'click', () ->
      setPage(4)

    $smContRow.on 'click', () ->
      setPage(5)

    # small menubar dropdown
    $('#smMenu').on 'click', () ->
      $('#slidemenu h1').css 'color', '#F1EFE6'
      $('#slidemenu h1:nth-of-type(' + (whichPage + 1) + ')').css 'color', '#F26522'
      if $slidemenu.hasClass 'hidden'
        $slidemenu.removeClass 'hidden'
      else
        $slidemenu.addClass 'hidden'

    # small menubar click outside hide
    $(document).on 'click', (e) ->
      if !$(e.target).closest('#slidemenu').length and !$(e.target).closest('#smMenu').length
        if !$slidemenu.hasClass 'hidden'
          $slidemenu.addClass 'hidden'

    # slide listeners
    $slideHome.on 'click', () ->
      $slidemenu.addClass 'hidden'
      home()
    $slideAbou.on 'click', () ->
      $slidemenu.addClass 'hidden'
      setPage 4
    $slideCont.on 'click', () ->
      $slidemenu.addClass 'hidden'
      setPage 5
    $slideCapa.on 'click', () ->
      $slidemenu.addClass 'hidden'
      setPage 1
    $slideProd.on 'click', () ->
      $slidemenu.addClass 'hidden'
      setPage 2
    $slideServ.on 'click', () ->
      $slidemenu.addClass 'hidden'
      setPage 3

    # resize listener
    $window.on 'resize', () ->
      middleResize(whichPage)

    # slideshow bubbles
    $bubbleDiv.on 'click', 'img', () ->
      timer_main.reset()
      oldWhichMainSlide = whichMainSlide
      if !$(this).is(':first-child')
        whichMainSlide = $(this).index()
      else
        whichMainSlide = $bubbleDiv.length - 1
      swapMainSlide()

    ### # # # # # # # # # # # CAPA PAGE # # # # # # # # # # # ###

    # tile hover animation
    $capaTiles.on 'mouseover', 'div img', () ->
      if $window.width() > 992
        $(this).stop().animate {'top':'20%'}, 200
        color_image = $('#capaList div:nth-of-type(' + (parseInt($(this).parent('div').index()) + parseInt(1)) + ') h3').text()
        $(this).attr 'src', '../../../assets/images/uploads/' + colorPics[color_image]
        $('#capaList div h3:contains("' + $(this).siblings('a').text() + '")').stop().animate {'font-size':'15'}, 200
        $('#capaList div h3:contains("' + $(this).siblings('a').text() + '")').css 'color', '#1352A5'
    $capaTiles.on 'mouseleave', 'div img', () ->
      if $window.width() > 992
        $(this).stop().animate {'top': '0'}, 200
        bw_image = $('#capaList div:nth-of-type(' + (parseInt($(this).parent('div').index()) + parseInt(1)) + ') h3').text()
        $(this).attr 'src', '../../../assets/images/uploads/' + bwPics[bw_image]
        $('#capaList div h3:contains("' + $(this).siblings('a').text() + '")').stop().animate {'font-size':'12'}, 200
        $('#capaList div h3:contains("' + $(this).siblings('a').text() + '")').css 'color', '#605F5B'

    # tile click lightbox
    $capaTiles.on 'click', 'div img', () ->
      $('#wrapper a[rel="lightbox[' + $(this).siblings('a').text() + ']"]:nth-of-type(1)').click()

    # list -> tile hover animation
    $capaList.on 'mouseover', 'div', () ->
      $(this).children('h3').stop().animate {'font-size':'15'}, 200
      $(this).children('h3').css 'color', '#1352A5'
      $('.capaTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').stop().animate {'top':'20%'}, 200
      $('.capaTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').addClass 'grayscale-disabled'
    $capaList.on 'mouseleave', 'div', () ->
      if ($(this).index() + 1) != capaWhichCate
        $(this).children('h3').css 'color', '#605F5B'
        $(this).children('h3').stop().animate {'font-size':'12'}, 200
      $('.capaTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').stop().animate {'top':'0'}, 200
      $('.capaTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').removeClass 'grayscale-disabled'

    # list -> tile click animation
    $capaList.on 'click', 'div', () ->
      $('.capaTiles div:nth-of-type(' + ($(this).index() + 1) + ') a').click()

    ### # # # # # # # # # # # PROD PAGE # # # # # # # # # # # ###

    # tile hover animation
    $prodTiles.on 'mouseover', 'div img', () ->
      if $window.width() > 992
        $(this).stop().animate {'top':'20%'}, 200
        color_image = $('#prodList div:nth-of-type(' + (parseInt($(this).parent('div').index()) + parseInt(1)) + ') h3').text()
        $(this).attr 'src', '../../../assets/images/uploads/' + colorPics[color_image]
        $('#prodList div h3:contains("' + $(this).siblings('a').text() + '")').stop().animate {'font-size':'15'}, 200
        $('#prodList div h3:contains("' + $(this).siblings('a').text() + '")').css 'color', '#1352A5'
    $prodTiles.on 'mouseleave', 'div img', () ->
      if $window.width() > 992
        $(this).stop().animate {'top': '0'}, 200
        bw_image = $('#prodList div:nth-of-type(' + (parseInt($(this).parent('div').index()) + parseInt(1)) + ') h3').text()
        $('#prodList div h3:contains("' + $(this).siblings('a').text() + '")').stop().animate {'font-size':'12'}, 200
        $('#prodList div h3:contains("' + $(this).siblings('a').text() + '")').css 'color', '#605F5B'

    # tile click lightbox
    $prodTiles.on 'click', 'div img', () ->
      $('#wrapper a[rel="lightbox[' + $(this).siblings('a').text() + ']"]:nth-of-type(1)').click()

    # list -> tile hover animation
    $prodList.on 'mouseover', 'div', () ->
      $(this).children('h3').stop().animate {'font-size':'15'}, 200
      $(this).children('h3').css 'color', '#1352A5'
      $('.prodTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').stop().animate {'top':'20%'}, 200
      $('.prodTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').addClass 'grayscale-disabled'
    $prodList.on 'mouseleave', 'div', () ->
      if ($(this).index() + 1) != prodWhichCate
        $(this).children('h3').css 'color', '#605F5B'
        $(this).children('h3').stop().animate {'font-size':'12'}, 200
      $('.prodTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').stop().animate {'top':'0'}, 200
      $('.prodTiles div:nth-of-type(' + ($(this).index() + 1) + ') img').removeClass 'grayscale-disabled'

    # list -> tile click animation
    $prodList.on 'click', 'div', () ->
      $('.prodTiles div:nth-of-type(' + ($(this).index() + 1) + ') a').click()

  init()
