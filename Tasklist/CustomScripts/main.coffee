String.prototype.shorten = ->
  words = @split ' '
  shorten = words[0]
  shorten += words[i] for i in [1...words.length]
  return shorten

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

  change: (changedTask) ->
    $.ajax '/Home/Change',
      type: "POST"
      data: changedTask
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
      input = $('.editor-field input').val().shorten()
      if input
        ajax.add input
        $('.editor-field input').val ''
      else
        alert "Error! Invalid task!"
  change:
    submit: (event) ->
      event.preventDefault()
      changedTask =
        newTask: $(@).serializeArray()[0].value
        id: $(@).parent().parent().data "id"
      ajax.change changedTask
    dblclick: (event) ->
      event.preventDefault()
      value = $(@).html()
      html = "<form autocomplete=\"off\" id=\"changing\"><input name=\"task\" type=\"text\" value=\"#{value}\" autofocus/></form>"
      $(@).html html
      $(@).children('input').first().focus()
      $('#changing').on 'submit', action.change.submit

  remove:
    click: ->

$(document).on 'ready', ->
  $('#Task').focus()
  $('form').attr 'autocomplete', 'off'

  $('form').first().on 'submit', action.add.submit

  $('li span').on 'dblclick', action.change.dblclick
