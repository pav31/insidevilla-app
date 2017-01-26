jQuery ->
  if gon.slider
    for key of gon.slider
      $('#slide_' + key).backstretch(gon.slider[key])
