'use strict'

angular.module 'cmsApp'
.controller 'CmsCtrl', ($scope) ->

  # commonly used jQuery handles
  $window = $(window)
  $wrapper = $('#wrapper')
  $content = $('#content')

  # 'globals'
  contentWidth = $window.width()*0.90

  # the following arrays will be populated by calls to the db
  

  # sets up the layout of the page
  initLayout = () ->
    $wrapper.height($window.height()*0.90)
    $wrapper.css 'margin-top', ($window.height()*0.10 / 2)
    $content.width(contentWidth)
    $content.css 'margin-left', -1*(contentWidth / 2)

  # basically document.ready
  init = () ->

    # setup layout of page
    initLayout()

    # resize listener
    $window.on 'resize', () ->
      $wrapper.height($(window).height()*0.90)
      $wrapper.css 'margin-top', ($window.height()*0.10 / 2)

  # run init()
  init()
