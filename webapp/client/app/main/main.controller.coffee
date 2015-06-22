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

  # functions
  setColor = () ->

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

  init()
