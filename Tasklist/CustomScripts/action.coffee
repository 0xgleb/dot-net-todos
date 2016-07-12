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
      else if confirm 'Are you sure you want to remove this task?'
        modules.ajax.remove changedTask.id
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
  check: ->
    li = $(@).parent()
    if parseInt(li.attr('class')) == 1
      li.removeClass '1'
      li.addClass '0'
    else
      li.removeClass '0'
      li.addClass '1'

    modules.action.select()
    modules.ajax.changeStatus parseInt $(@).parent().data 'id'

  select: =>
    console.log @
    modules.action.selectedOptions[$('select').val()]()

  selectedOptions:
    all: ->
      console.log 'all'
      $('.1, .0').show()
    active: ->
      console.log 'active'
      $('.1').hide()
      $('.0').show()
    done: ->
      console.log 'done'
      $('.0').hide()
      $('.1').show()
