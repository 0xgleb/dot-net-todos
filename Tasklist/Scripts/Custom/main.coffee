ajax =
  add: (input)->
    $.ajax '/Home/Add',
      type: "POST"
      data: $(@).serialize()
      beforeSend: ->
      success: (response) ->
        console.log response
        resp = response
        errors = true if response == -1
        if response != -1
          $('ul').append "<li data-id='#{response}'><input type='checkbox' /><span>#{input}</span>  <button>Remove</button></li>"
        else
          alert "Error!"
      timeout: 3000,
      error: (request, errorType, errorMessage) ->
        errors = true
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
        if response != -1
          console.log @
        else
          alert "Error!"
      timeout: 3000
      error: (request, errorType, errorMessage) ->
        errors = true
        console.log "Error #{errorType} with message: #{errorMessage} [clientside]"
      complete: ->
        console.log "Loading finished! [clientside]"


  remove: (id) ->
    console.log 'test'

event =
  add:
    submit: (event) ->
      event.preventDefault()
      input = $('.editor-field input').val()
      console.log "#{input} (input) [clientside]"
      errors = false
      ajax.add input
  change:
    submit: (event) ->
      event.preventDefault()
      errors = false
      ajax.change $(@).data("data-id")
    dblclick: ->
      value = $(@).html()
      console.log $ @
      html = "<form id='changing'><input type='text' value='#{value}' autofocus/></form>"
      console.log html
      $(@).html html
      $(@).children('input').first().focus()
      console.log 'ID: ' + $(@).data "id"

$(document).on 'ready', ->
  $('#Task').focus()
  $('form').attr 'autocomplete', 'off'
  .attr 'action', '/Home/Add'

  $('form').on 'submit', event.add.submit

  $('li span').on 'dblclick', event.change.dblclick

  $('#changing').on 'submit', event.change.submit
