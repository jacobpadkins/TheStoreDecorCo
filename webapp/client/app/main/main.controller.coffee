'use strict'

angular.module 'webappApp'
.controller 'MainCtrl', ($scope) ->

  # cached jQuery variables
  $window = $(window)
  $logo = $('#logo')
  $rowCapa = $('#rowCapa')
  $rowServ = $('#rowServ')
  $rowProd = $('#rowProd')
  $secImg = $('#sectionImage')

  # other variables

  # functions
  clearPage = (which) ->
    $('html, body').animate {scrollTop: 0}, 500, () ->
      $('#slide').animate {'height':'135px'}, 1000
      $('#tagline, #copyText, #divider, #middle, #bottom').fadeOut 1000, () ->
        $('#middle').empty().addClass('Capabilities').append  '<div class="col-md-1"></div>
                                                                <div id="list" class="col-md-2"></div>
                                                                <div id="tiles" class="col-md-8"></div>
                                                                <div class="col-md-1"></div>'
        $('#middle, #bottom').fadeIn 1000
  # $(document).ready()
  init = () ->
    # initially hide image
    $secImg.fadeOut 0

    # hide/show logo on scroll
    $(window).scroll () ->
      if $window.scrollTop() > 10
        $logo.fadeOut()
      else
        $logo.fadeIn()

    # section image display
    $rowCapa.on 'mouseover', () ->
      # display Capabilities image
      $secImg.css 'background-image', 'url("../../../assets/images/home1.jpg")'
      $secImg.fadeIn 'fast'
    $rowCapa.on 'mouseleave', () ->
      $secImg.fadeOut 0
    $rowServ.on 'mouseover', () ->
      # display Capabilities image
      $secImg.css 'background-image', 'url("../../../assets/images/home2.jpg")'
      $secImg.fadeIn 'fast'
    $rowServ.on 'mouseleave', () ->
      $secImg.fadeOut 0
    $rowProd.on 'mouseover', () ->
      # display Capabilities image
      $secImg.css 'background-image', 'url("../../../assets/images/home3.jpg")'
      $secImg.fadeIn 'fast'
    $rowProd.on 'mouseleave', () ->
      $secImg.fadeOut 0

    # change page on click
    $rowProd.on 'click', () ->
      clearPage(0);
    $rowServ.on 'click', () ->
      clearPage(1);
    $rowProd.on 'click', () ->
      clearPage(2);
  init()
