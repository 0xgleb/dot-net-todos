modules.action =
  add:
    submit: (event) ->
      event.preventDefault()
      input = $('#Task').val().shorten()
      if input && input.toLegal().length
        input = input.toLegal()
        $('table').append "<tr class=\"1\"><td><input type='checkbox' class=\"checkbox\" autocomplete=\"off\"/></td><td><span class=\"task\">#{input}</span></td><td>#{modules.userName}</td><td>#{(eval $('form').serializeArray()[2].value).toStatus()}</td><td><button class=\"remove btn btn-default btn-sm\">X</button></td></tr>"
        console.log input.length
        modules.ajax.add input
        $('#Task').val ''
      else
        alert "Error! Invalid task!"
  change:
    submit: (event) ->
      event.preventDefault()

      changedTask =
        newTask: $(@).serializeArray()[0].value.shorten().toLegal()
        id: $(@).parent().parent().parent().data "id"
      if changedTask.newTask
        console.log changedTask.newTask
        changedTask.newTask = changedTask.newTask
        $(@).parent().html "#{changedTask.newTask}"
        modules.ajax.change changedTask
      else if confirm 'Are you sure you want to remove this task?'
        modules.ajax.remove changedTask.id
        $(@).parent().parent().parent().remove()
    dblclick: (event) ->
      event.preventDefault()

      value = $(@).html()
      html = "<form class=\"form-inline\" autocomplete=\"off\" id=\"changing\"><input name=\"task\" type=\"text\" value=\"#{value}\" autofocus class=\"form-control\"/></form>"
      $(@).html html
      $(@).children('input').first().focus()

      $('#changing').on 'submit', modules.action.change.submit

  remove:
    click: ->
      tr = $(@).parent().parent()
      modules.ajax.remove parseInt tr.data 'id'
      tr.remove()
  check: ->
    tr = $(@).parent().parent()
    if parseInt(tr.attr('class')) == 1
      tr.removeClass '1'
      tr.addClass '0'
    else
      tr.removeClass '0'
      tr.addClass '1'

    modules.action.select()
    modules.ajax.changeStatus parseInt tr.data 'id'

  select: =>
    modules.action.selectedOptions[$('select').val()]()

  selectedOptions:
    all: ->
      $('.1, .0').show()
    active: ->
      $('.0').hide()
      $('.1').show()
    done: ->
      $('.1').hide()
      $('.0').show()
