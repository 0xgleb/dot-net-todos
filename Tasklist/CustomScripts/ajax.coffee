modules.ajax =
  add: (input) =>
    $.ajax '/Home/Add',
      type: "POST"
      data: $('form').serialize()
      beforeSend: ->
      success: (response) ->
        response = parseInt response
        if response == -1
          alert "Error!"
        else
          console.log 'Should add attr'
          $('ul').children('li').last().attr 'data-id', response
      timeout: 3000,
      error: @error
      complete: ->

  change: (changedTask) =>
    $.ajax '/Home/Change',
      type: "POST"
      data: changedTask
      beforeSend: ->
      success: (response) ->
        response = parseInt response
        console.log response
        if response == -1
          alert "Error!"
      timeout: 3000
      error: @error
      complete: ->

  sendId: (id, url) ->
    $.ajax url,
      type: "POST"
      data: {id}
      beforeSend: ->
      success: (response) ->
        console.log response
        response = parseInt response
        if response == -1
          alert 'Error!'
        else
          console.log $ @
          $(@).remove()
      timeout: 3000
      error: modules.ajax.error
      complete: ->
        console.log "Loading finished! [clientside]"

  error: (request, errorType, errorMessage) ->
    alert "Error! #{errorMessage}!"
    console.log "Error \"#{errorType}\": #{errorMessage}!"
