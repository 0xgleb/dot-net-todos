$(document).on 'ready', ->
  $('#Task').focus()

  $('form').attr 'autocomplete', 'off'
  $('form').first().on 'submit', modules.action.add.submit

  $('.task').on 'dblclick', modules.action.change.dblclick
  $('tr').on 'click', 'button', modules.action.remove.click
  $('tr').on 'change', '.checkbox', modules.action.check
  # $('li').on 'click', 'span', modules.action.check

  $('select').on 'change', modules.action.select
