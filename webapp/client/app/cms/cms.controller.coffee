'use strict'

angular.module 'webappApp'
.controller 'CmsCtrl', ($scope, $http) ->

  route = 'api/cms'

  set_preview = (input) ->
    if input.files and input.files[0]
      reader = new FileReader()
      reader.onload = (e) ->
        $('#file_preview').attr 'src', e.target.result
      reader.readAsDataURL(input.files[0])

  populate_images = () ->
    $http({
      url: route + '/images',
      method: 'GET'
    }).success (response) ->
      i = 0
      while i < response.length
        $('#images_col').append '<div class="image">
                                  <div class="x_box"></div>
                                  <div class="x_mark">
                                   <span>' + response[i] + '</span>
                                  </div>
                                 </div>'
        i += 1

  # basically $(document).ready()
  init = () ->

    populate_images()

    $('#file_select').change () ->
      set_preview(this)

    $('#file_upload').on 'click', () ->
      if $('#file_select').val()
        $('form').submit()

    $('#images_col').on 'mouseover', '.image', () ->
      $('#file_preview').attr 'src', '../../../assets/images/uploads/' + $(this).children('.x_mark').children('span').text()

  init()
