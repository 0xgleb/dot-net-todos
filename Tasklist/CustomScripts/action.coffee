modules.action =
  add:
    submit: (event) ->
      event.preventDefault()
      input = $('.editor-field input').val().shorten()
      if input
        modules.ajax.add input
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
        modules.ajax.change changedTask
      else
        alert 'Error! Invalid task!'
    dblclick: (event) ->
      event.preventDefault()

      value = $(@).html()
      html = "<form autocomplete=\"off\" id=\"changing\"><input name=\"task\" type=\"text\" value=\"#{value}\" autofocus/></form>"
      $(@).html html
      $(@).children('input').first().focus()

      $('#changing').on 'submit', modules.action.change.submit

  remove:
    click: ->
      if confirm 'Are you sure?'
        li = $(@).parent()
        modules.ajax.remove parseInt li.data 'id'
        li.remove()
