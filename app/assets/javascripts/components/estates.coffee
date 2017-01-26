jQuery ->
  #
  # Image Upload
  #

  $('#attachment').attr('name', 'image[attachment]')
  $('#fileupload').fileupload
    dataType: 'script'
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('#fileupload').append(data.context)
        data.submit()
      else
        alert("#{file.name} is not a gif, jpg or png image file")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.meter').css('width', progress + '%')
        data.context.find('p.percent').text(progress + '%')

  #
  # Estate Header BG
  #

  if gon.slider_url
    $("#object_header_photo").backstretch(gon.slider_url)

  #
  # Filter regions based on selected place in create form
  #

  estatePlace = $('#estate_place')
  estateRegion = $('#estate_region')
  origPlaceVal = estatePlace.val()
  origRegionVal = estateRegion.val()
  regionOptions = estateRegion.find('option')

  # Init State
  regionOptions.not('option[value*="' + origPlaceVal + '"]').remove()
  estateRegion.val(origRegionVal)

  estatePlace.change ->
    estateRegion.append(regionOptions)
    regionOptions.not('option[value*="' + @value + '"]').remove()

    if origPlaceVal == estatePlace.val() && !!(origRegionVal)
      estateRegion.val(origRegionVal)
    else
      estateRegion.first

  #
  # Filter regions based on selected place in search form
  #
  # initPl: Initial Place
  # RgCh: Region Change
  # PlCh: Place Change
  # 0: blank option (all selected)
  # 1: selected option
  #
  # Switch logic
  # initPl->RgCh->PlCh
  #   00 -> 01 -> 10
  #   01 -> 10 -> 00
  #   10 -> 11 -> 01
  #   11 -> 10 -> 00
  estatePlaceQ = $('#q_place_eq')
  estateRegionQ = $('#q_region_eq')
  origPlaceValQ = estatePlaceQ.val()
  origRegionValQ = estateRegionQ.val()
  regionOptionsQ = estateRegionQ.find('option')
  blankOpt = regionOptionsQ.first()

  # Initial state
  if !!(origPlaceValQ)
    estateRegionQ.append(regionOptionsQ)
    regionOptionsQ.not('option[value*="' + origPlaceValQ + '"]').remove()
    estateRegionQ.prepend(blankOpt)
    estateRegionQ.val(origRegionValQ)

  estatePlaceQ.change ->
    currentPlaceValQ = estatePlaceQ.val()
    currentRegionValQ = estateRegionQ.val()
    estateRegionQ.append(regionOptionsQ)

    # Place changed to all & Region selected (11->01)
    if currentPlaceValQ == '' && !!(currentRegionValQ)
      estateRegionQ.val(
        estateRegionQ.find('option[value=' + currentRegionValQ + ']').val()
      )
    # Place changed from all & Region selected one or all (10->00 / 11 -> 01)
    # OR
    # Place changed from all & Region selected all (01 -> 00)
    else
      if !!(currentPlaceValQ)
        regionOptionsQ.not('option[value*="' + @value + '"]').remove()
        estateRegionQ.prepend(blankOpt)
      estateRegionQ.val('')
