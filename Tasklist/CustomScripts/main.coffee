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
        task: $(@).serializeArray()[0]
      beforeSend: ->
      success: (response) ->
        console.log response
        ###response = parseInt response
        console.log response
        if response != -1
          console.log @
          $(@).parent().html "#{$(@).serializeArray()[0]}"
        else
          alert "Error!" ###
      timeout: 3000
      error: (request, errorType, errorMessage) ->
        console.log "Error #{errorType} with message: #{errorMessage} [clientside]"
      complete: ->
        console.log "Loading finished! [clientside]"

  remove: (id) ->
    console.log ''

action =
  add:
    submit: (event) ->
      event.preventDefault()
      ajax.add $('.editor-field input').val()
      $('.editor-field input').val ''
  change:
    submit: (event) ->
      event.preventDefault()
      console.log $(@).parent().data 'id'
      console.log $(@).serializeArray()[0]
      changedTask =
        task = $(@).serializeArray()[0].value
        id = $(@).parent().data 'id'
      ajax.change $(@).parent().data "id"
    dblclick: (event) ->
      event.preventDefault()
      value = $(@).html()
      html = "<form autocomplete=\"off\" id=\"changing\"><input name=\"task\" type=\"text\" value=\"#{value}\" autofocus/></form>"
      $(@).html html
      # console.log $ @
      # console.log $(@).children 'input'
      # console.log $(@).children('input').first()
      $(@).children('input').first().focus()
      console.log 'ID: ' + $(@).parent().data "id"
      $('#changing').on 'submit', action.change.submit

    remove:
      click: ->

$(document).on 'ready', ->
  $('#Task').focus()
  $('form').attr 'autocomplete', 'off'

  $('form').first().on 'submit', action.add.submit

  $('li span').on 'dblclick', action.change.dblclick
