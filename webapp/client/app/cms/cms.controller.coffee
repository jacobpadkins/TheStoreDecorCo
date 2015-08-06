'use strict'

angular.module 'webappApp'
.controller 'CmsCtrl', ($scope, $http) ->

  set_preview = (input) ->
    if input.files and input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->
        $('#file_preview').attr 'src', e.target.result
      reader.readAsDataURL(input.files[0])

  # basically $(document).ready()
  init = () ->

    $('#file_select').change () ->
      set_preview(this)

    $('#file_upload').on 'click', () ->
      if $('#file_select').val()
        $('form').submit()

  init()
