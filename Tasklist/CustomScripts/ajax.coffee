modules.ajax =
  add: (input) =>
    $.ajax 'Home/Add',
      type: "POST"
      data: $('form').serialize()
      beforeSend: ->
      success: (response) ->
        response = parseInt response
        console.log response
        if response == -1
          alert "Error!"
        else
          $('table').children('tr').last().attr 'data-id', response
      timeout: 3000,
      error: @error
      complete: ->

  change: (changedTask) =>
    $.ajax 'Home/Change',
      type: "POST"
      data: changedTask
      beforeSend: ->
      success: (response) ->
        response = parseInt response
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
        response = parseInt response
        if response == -1
          alert 'Error!'
        else
          $(@).remove()
      timeout: 3000
      error: modules.ajax.error
      complete: ->
        console.log "Loading finished! [clientside]"

  remove: (id) ->
    modules.ajax.sendId id, 'Home/Remove'

  changeStatus: (id) ->
    modules.ajax.sendId id, 'Home/Done'

  error: (request, errorType, errorMessage) ->
    alert "Error! #{errorMessage}!"
    console.log "Error \"#{errorType}\": #{errorMessage}!"
