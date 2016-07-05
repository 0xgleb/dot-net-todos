$(document).on 'ready', ->
  $('form').on 'submit', (event) ->
    event.preventDefault()
    input = $('.editor-field input').val()
    console.log "#{input} (input) [clientside]"
    errors = false
    $.ajax '/Home/Index',
      type: "POST"
      data: $('form').serialize()
      beforeSend: ->
      success: (response) ->
        console.log response
        errors = true if response == "Error! [serverside]"
      timeout: 3000,
      error: (request, errorType, errorMessage) ->
        errors = true
        console.log "Error #{errorType} with message: #{errorMessage} [clientside]"
      complete: ->
        console.log "Loading finished! [clientside]"
        if !errors
          $('ul').append "<li>#{input}</li>"
        else
          alert "Error!"
