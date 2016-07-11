String.prototype.shorten = ->
  words = @split ' '

  if words[0]
    shorten = words[0]
    for i in [1...words.length]
      shorten += ' ' + words[i] if words[i]
    shorten
  else
    null

ajax =
  add: (input)->
    $.ajax '/Home/Add',
      type: "POST"
      data: $('form').serialize()
      beforeSend: ->
      success: (response) ->
        response = parseInt response
        if response == -1
          alert "Error!"
        else
          $('ul').last('li').attr data-id, response
      timeout: 3000,
      error: ajax.error
      complete: ->

  change: (changedTask) ->
    $.ajax '/Home/Change',
      type: "POST"
      data: changedTask
      beforeSend: ->
      success: (response) ->
        response = parseInt response
        console.log response
        if response == -1
          console.log @
          alert "Error!"
      timeout: 3000
      error: ajax.error
      complete: ->

  remove: (id) ->
    $.ajax '/Home/Remove',
      type: "POST"
      data: id
      beforeSend: ->
      success: (response) ->
        response = parseInt response
        if response == -1
          alert 'Error!'
        else
          $(@).parent().remove()
      timeout: 3000
      error: ajax.error
      complete: ->
        console.log "Loading finished! [clientside]"

  error: (request, errorType, errorMessage) ->
    alert "Error! #{errorMessage}!"
    console.log "Error \"#{errorType}\": #{errorMessage}!"

action =
  add:
    submit: (event) ->
      event.preventDefault()
      input = $('.editor-field input').val().shorten()
      if input
        ajax.add input
        $('.editor-field input').val ''
        $('ul').append "<li><input type='checkbox' /><span>#{input}</span>  <button>Remove</button></li>"
      else
        alert "Error! Invalid task!"
  change:
    submit: (event) ->
      event.preventDefault()

      changedTask =
        newTask: $(@).serializeArray()[0].value.shorten()
        id: $(@).parent().parent().data "id"
      if changedTask.newTask
        $(@).parent().html "#{changedTask.newTask}"
        ajax.change changedTask
      else
        alert 'Error! Invalid task!'
    dblclick: (event) ->
      event.preventDefault()

      value = $(@).html()
      html = "<form autocomplete=\"off\" id=\"changing\"><input name=\"task\" type=\"text\" value=\"#{value}\" autofocus/></form>"
      $(@).html html
      $(@).children('input').first().focus()

      $('#changing').on 'submit', action.change.submit

  remove:
    click: ->
      if confirm 'Are you sure?'
        ajax.remove $(@).parent().data 'id'

$(document).on 'ready', ->
  $('#Task').focus()
  $('form').attr 'autocomplete', 'off'

  $('form').first().on 'submit', action.add.submit

  $('li span').on 'dblclick', action.change.dblclick

  $('li').on 'click', 'button', action.remove.click
