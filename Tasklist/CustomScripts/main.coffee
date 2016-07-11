$(document).on 'ready', ->
  $('#Task').focus()
  $('form').attr 'autocomplete', 'off'

  $('form').first().on 'submit', modules.action.add.submit

  $('li span').on 'dblclick', modules.action.change.dblclick

  $('li').on 'click', 'button', modules.action.remove.click
