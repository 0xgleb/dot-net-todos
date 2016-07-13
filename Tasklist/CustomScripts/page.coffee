modules.page =
  init: ->
    console.log modules.userName
    $('#Task').focus()
    $('form').attr 'autocomplete', 'off'
    $('form').first().on 'submit', modules.action.add.submit
    $('select').on 'change', modules.action.select

    $('.task').on 'dblclick', modules.action.change.dblclick
    $('.remove').on 'click', modules.action.remove.click
    $('.checkbox').on 'change', modules.action.check
    # $('li').on 'click', 'span', modules.action.check

  reloadEventListeners: ->
    $('.task').off('dblclick').on 'dblclick', modules.action.change.dblclick
    $('.remove').off('click').on 'click', modules.action.remove.click
    $('.checkbox').off('change').on 'change', modules.action.check
