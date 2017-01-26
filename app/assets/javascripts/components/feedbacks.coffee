jQuery ->
  $('#feedback_photo').on 'change', (event) ->
    files = event.target.files
    image = files[0]
    reader = new FileReader

    reader.onload = (file) ->
      img = new Image
      img.src = file.target.result
      $('#target').html(img).css 'height', 100

    reader.readAsDataURL image

  # Feedback max length counter
  feedback_body = $('#feedback_body')
  counter = $('#counter')
  max_length = counter.data('maximum-length')
  feedback_body.keyup ->
    counter.text(max_length - ($(this).val().length))