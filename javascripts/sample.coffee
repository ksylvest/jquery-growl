$ -> 

  $.growl 
    title: "Growl"
    message: "The kitten is awake!"

  $('.error').click (event) ->
    event.preventDefault()
    event.stopPropagation()
    $.growl.error
      message: "The kitten is attacking!"

  $('.notice').click (event) ->
    event.preventDefault()
    event.stopPropagation()
    $.growl.notice
      message: "The kitten is cute!"

  $('.warning').click (event) ->
    event.preventDefault()
    event.stopPropagation()
    $.growl.warning
      message: "The kitten is ugly!"
