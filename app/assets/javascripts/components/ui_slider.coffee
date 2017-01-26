$(document).on 'ready page:load', ->
  uiSlider = $('#ui-slider')
  inputFrom = $('#price_period_gteq')
  inputUpto = $('#price_period_lteq')
  pricePeriod = $('input[type=radio][name=price_period]')

  uiSlider.slider({
    animate: 'fast'
  });

  if not gon.from_price_day
    gon.from_price_day = gon.min_range_day
    gon.upto_price_day = gon.max_range_day
  if not gon.from_price_month
    gon.from_price_month = gon.min_range_month
    gon.upto_price_month = gon.max_range_month

  get_current_period = ->
    $('input[type=radio][checked=checked]').val()
  
  resetSlider = (period) ->
    if period == 'day'
      min = gon.min_range_day
      max = gon.max_range_day
      values_min = gon.from_price_day 
      values_max = gon.upto_price_day
    else
      min = gon.min_range_month
      max = gon.max_range_month
      values_min = gon.from_price_month
      values_max = gon.upto_price_month
    
    uiSlider.slider
      range: true
      min: min
      max: max
      values: [
        values_min
        values_max
      ]
      slide: (event, ui) ->
        inputFrom.val ui.values[0]
        inputFrom.attr 'value', ui.values[0]
        inputUpto.val ui.values[1]
        inputUpto.attr 'value', ui.values[1]


    inputFrom.val uiSlider.slider('values', 0)
    inputUpto.val uiSlider.slider('values', 1)

  # Initiate Slider
  resetSlider get_current_period()

  # Initiate Listen to input 'from' value change
  inputFrom.on 'change', ->
    uiSlider.slider('values', 0, @value);
    return

  # Initiate Listen to input 'upto' value change
  inputUpto.on 'change', ->
    uiSlider.slider('values', 1, @value);
    return

  # Initiate Listen to period change
  pricePeriod.on 'change', ->
    resetSlider @value
    inputFrom.attr('name', "q[price_" + @value + "_low_cents_gteq_price]")
    inputUpto.attr('name', "q[price_" + @value + "_low_cents_lteq_price]")
