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
    $('#images_col').empty()
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

  delete_image = (file) ->
    $http({
      url: route + '/images',
      method: 'DELETE',
      params: {filename: file}
    }).success () ->
      populate_images()

  # basically $(document).ready()
  init = () ->

    populate_images()

    # preview on selecting an image
    $('#file_select').change () ->
      set_preview(this)

    # upload file submit event
    $('#file_upload').on 'click', () ->
      if $('#file_select').val()
        $('form').submit()

    # display preview on hover
    $('#images_col').on 'mouseover', '.image', () ->
      if !$('#file_select').val()
        $('#file_preview').attr 'src', '../../../assets/images/uploads/' + $(this).children('.x_mark').children('span').text()

    #delete image on clicking cross
    $('#images_col').on 'click', '.image .x_box', () ->
      delete_image($(this).siblings('.x_mark').children('span').text())

  init()
