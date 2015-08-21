'use strict'

angular.module 'webappApp'
.controller 'CmsCtrl', ($scope, $http) ->

  route = 'api/cms'
  selected_file = ''
  selected = false

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
      response.sort()
      i = 0
      while i < response.length
        $('#images_col').append '<div class="image">
                                  <div class="x_box"></div>
                                  <input type="checkbox" name="Big_Slide">
                                  <input type="checkbox" name="Small_Slide">
                                  <div class="x_mark">
                                   <span>' + response[i] + '</span>
                                  </div>
                                 </div>'
        i += 1

  populate_categories = () ->
    $('#capas_col, #prods_col').empty()
    $http({
      url: route + '/capa',
      method: 'GET'
    }).success (response) ->
      response.sort()
      i = 0
      while i < response.length
        $('#capas_col').append '<div class="capa">
                                 <div class="x_box"></div>
                                 <input type="checkbox" name="is_a">
                                 <input type="checkbox" name="rep_color">
                                 <input type="checkbox" name="rep_bw">
                                 <div class="x_mark">
                                  <span>' + response[i] + '</span>
                                 </div>
                                </div>'
        i++
    $http({
      url: route + '/prod',
      method: 'GET'
    }).success (response) ->
      response.sort()
      i = 0
      while i < response.length
        $('#prods_col').append '<div class="prod">
                                 <div class="x_box"></div>
                                 <input type="checkbox" name="is_a">
                                 <input type="checkbox" name="rep_color">
                                 <input type="checkbox" name="rep_bw">
                                 <div class="x_mark">
                                  <span>' + response[i] + '</span>
                                 </div>
                                </div>'
        i++

  delete_image = (file) ->
    $http({
      url: route + '/images',
      method: 'DELETE',
      params: {filename: file, password: $('#password').val()}
    }).success () ->
      populate_images()

  add_capa = (capa) ->
    $http({
      url: route + '/capa',
      method: 'POST',
      params: {category: capa, password: $('#password').val()}
    }).success () ->
      populate_categories()

  delete_capa = (capa) ->
    $http({
      url: route + '/capa',
      method: 'DELETE',
      params: {category: capa, password: $('#password').val()}
    }).success () ->
      populate_categories()

  add_prod = (prod) ->
    $http({
      url: route + '/prod',
      method: 'POST',
      params: {category: prod, password: $('#password').val()}
    }).success () ->
      populate_categories()

  delete_prod = (prod) ->
    $http({
      url: route + '/prod',
      method: 'DELETE',
      params: {category: prod, password: $('#password').val()}
    }).success () ->
      populate_categories()

  # (1/0 - adding/removing, filename, capa/prod, name of category)
  lazy_func = (op, fi, ca, na) ->
    $http({
      url: route + '/images',
      method: 'PUT',
      params: {operation: op, file: fi, category: ca, name: na, password: $('#password').val()}
    })

  set_categories = (file) ->
    $http({
      url: route + '/images/tags',
      method: 'GET',
      params: {name: file}
    }).success (response) ->
      i = 0
      while i < response.Capabilities.length
        $('#capas_col span:contains("' + response.Capabilities[i] + '")').parent('.x_mark').siblings('input[name="is_a"]').prop 'checked', 'true'
        i++
      i = 0
      while i < response.Products.length
        $('#prods_col span:contains("' + response.Products[i] + '")').parent('.x_mark').siblings('input[name="is_a"]').prop 'checked', 'true'
        i++
      i = 0
      while i < response.Flags.length
        if response.Flags[i] == 'Small_Slide' or response.Flags[i] == 'Big_Slide'
          $('#images_col span:contains("' + file + '")').parent('.x_mark').siblings('input[name="' + response.Flags[i] + '"]').prop 'checked', 'true'
        else
          flag_obj = JSON.parse(response.Flags[i])
          flag_key = Object.keys(flag_obj)
          $('#capas_col, #prods_col').find('span:contains("' + flag_obj[flag_key[0]] + '")').parent('.x_mark').siblings('input[name="' + flag_key[0] + '"]').prop 'checked', 'true'
        i++

  clear_categories = () ->
    $('input:checked').removeAttr 'checked'

  # basically $(document).ready()
  init = () ->

    populate_images()
    populate_categories()

    # preview on selecting an image
    $('#file_select').change () ->
      selected_file = ''
      selected = false
      set_preview(this)

    # upload file submit event
    $('#file_upload').on 'click', () ->
      if $('#file_select').val()
        $('form').submit()

    # display preview on hover
    $('#images_col').on 'mouseover', '.image', () ->
      if !$('#file_select').val() and !selected
        $('#file_preview').attr 'src', '../../../assets/images/uploads/' + $(this).children('.x_mark').children('span').text()

    # clear display image on mouseleave
    $('#images_col').on 'mouseleave', '.image', () ->
      if !$('#file_select').val() and !selected
        $('#file_preview').attr 'src', ''

    # change selected image on click
    $('#images_col').on 'click', '.image .x_mark span', () ->
      $('#images_col .image').css 'background-color', ''
      clear_categories()
      if $(this).text() != selected_file
        selected_file = $(this).text()
        $('#file_preview').attr 'src', '../../../assets/images/uploads/' + $(this).text()
        $(this).parent('.x_mark').parent('.image').css 'background-color', '#F26522'
        set_categories($(this).text())
        selected = true
      else
        selected = false
        selected_file = ''

    # delete image on clicking cross
    $('#images_col').on 'click', '.image .x_box', () ->
      delete_image($(this).siblings('.x_mark').children('span').text())

    # add a capability category
    $('#capa_button').on 'click', () ->
      if $('#capa_input').val()
        add_capa($('#capa_input').val())
        $('#capa_input').val('')

    # add a product category
    $('#prod_button').on 'click', () ->
      if $('#prod_input').val()
        add_prod($('#prod_input').val())
        $('#prod_input').val('')

    # delete a capability category
    $('#capas_col').on 'click', '.capa .x_box', () ->
      delete_capa($(this).siblings('.x_mark').children('span').text())

    # delete a product category
    $('#prods_col').on 'click', '.prod .x_box', () ->
      delete_prod($(this).siblings('.x_mark').children('span').text())

    # change flags on checkbox changes - images_col
    $('#images_col').on 'change', 'input', () ->
      if selected and $(this).attr('name') != 'is_a' #TODO: why did I put this here. . . .?
        if $(this).is ':checked'
          lazy_func(1, $(this).siblings('.x_mark').children('span').text(), 'flag', $(this).attr('name'))
        else if !$(this).is ':checked'
          lazy_func(0, $(this).siblings('.x_mark').children('span').text(), 'flag', $(this).attr('name'))

    # change flags on checkbox changes - capas_col/prods_col
    $('#capas_col, #prods_col').on 'change', 'input', () ->
      if selected and $(this).attr('name') != 'is_a'
        if $(this).attr('name') == 'rep_color'
          flag_obj = {rep_color: $(this).siblings('.x_mark').children('span').text()}
          if $(this).is ':checked'
            lazy_func(1, selected_file, 'flag', flag_obj)
          else if !$(this).is ':checked'
            lazy_func(0, selected_file, 'flag', flag_obj)
        else if $(this).attr('name') == 'rep_bw'
          flag_obj = {rep_bw: $(this).siblings('.x_mark').children('span').text()}
          if $(this).is ':checked'
            lazy_func(1, selected_file, 'flag', flag_obj)
          else if !$(this).is ':checked'
            lazy_func(0, selected_file, 'flag', flag_obj)
      else if selected and $(this).attr('name') == 'is_a'
        if $('#capas_col').has($(this)).length
          if $(this).is ':checked'
            lazy_func(1, selected_file, 'capa', $(this).siblings('.x_mark').children('span').text())
          else if !$(this).is ':checked'
            lazy_func(0, selected_file, 'capa', $(this).siblings('.x_mark').children('span').text())
        else if $('#prods_col').has($(this)).length
          if $(this).is ':checked'
            lazy_func(1, selected_file, 'prod', $(this).siblings('.x_mark').children('span').text())
          else if !$(this).is ':checked'
            lazy_func(0, selected_file, 'prod', $(this).siblings('.x_mark').children('span').text())

  init()
