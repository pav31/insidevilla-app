jQuery ->
  $('#comfort_icon').on 'change', (event) ->
    files = event.target.files
    image = files[0]
    reader = new FileReader

    reader.onload = (file) ->
      img = new Image
      img.src = file.target.result
      $('#target').html(img).css 'width', 38

    reader.readAsDataURL image