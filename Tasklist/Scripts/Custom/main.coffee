ajax =
  add: (errors, input, resp)->
    $.ajax '/Home/Index',
      type: "POST"
      data: $('form').serialize()
      beforeSend: ->
      success: (response) ->
        console.log response
        resp = response
        errors = true if response == -1
      timeout: 3000,
      error: (request, errorType, errorMessage) ->
        errors = true
        console.log "Error #{errorType} with message: #{errorMessage} [clientside]"
      complete: ->
        console.log "Loading finished! [clientside]"
        if !errors
          $('ul').append "<li data-id='#{resp}'><input type='checkbox' /><span>#{input}</span>  <button>Remove</button></li>"
        else
          alert "Error!"
  change: (id) ->
  remove: ->

event =
  submit: (event) ->
    event.preventDefault()
    input = $('.editor-field input').val()
    console.log "#{input} (input) [clientside]"
    errors = false
    response = null
    ajax.add(errors, input, response)
  dblclick: ->
    value = $(@).children('span').first()
    value.html("<input type=text value=#{value.html()} autofocus/>")
    console.log @attr "data-id"
    # ajax.change @attr "data-id"

$(document).on 'ready', ->
  $('#Task').focus()
  $('form').attr 'autocomplete', 'off'

  $('form').on 'submit', event.submit

  $('li').on 'dblclick', event.dblclick
