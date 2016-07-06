ajax =
  add: (input)->
    $.ajax '/Home/Add',
      type: "POST"
      data: $('form').serialize()
      beforeSend: ->
      success: (response) ->
        response = parseInt response
        console.log response
        if response != -1
          $('ul').append "<li data-id='#{response}'><input type='checkbox' /><span>#{input}</span>  <button>Remove</button></li>"
        else
          alert "Error!"
      timeout: 3000,
      error: (request, errorType, errorMessage) ->
        console.log "Error #{errorType} with message: #{errorMessage} [clientside]"
      complete: ->
        console.log "Loading finished! [clientside]"

  change: (id) ->
    $.ajax '/Home/Change',
      type: "POST"
      data:
        id: id
        form: $(@).serialize()
      beforeSend: ->
      success: (response) ->
        console.log response
        if parseInt response != -1
          console.log @
        else
          alert "Error!"
      timeout: 3000
      error: (request, errorType, errorMessage) ->
        console.log "Error #{errorType} with message: #{errorMessage} [clientside]"
      complete: ->
        console.log "Loading finished! [clientside]"


  remove: (id) ->
    console.log 'test'

event =
  add:
    submit: (event) ->
      event.preventDefault()
      ajax.add $('.editor-field input').val()
  change:
    submit: (event) ->
      event.preventDefault()
      ajax.change $(@).data("data-id")
    dblclick: ->
      value = $(@).html()
      console.log $ @
      html = "<form id='changing'><input name='task' type='text' value='#{value}' autofocus/></form>"
      console.log html
      $(@).html html
      $(@).children('input').first().focus()
      console.log 'ID: ' + $(@).data "id"

$(document).on 'ready', ->
  $('#Task').focus()
  $('form').attr 'autocomplete', 'off'

  $('form').first().on 'submit', event.add.submit

  $('li span').on 'dblclick', event.change.dblclick

  $('#changing').on 'submit', event.change.submit
