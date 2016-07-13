String.prototype.shorten = ->
  words = @split ' '

  shorten = ''
  for i in [0...words.length]
    shorten += words[i] + ' ' if words[i]
  shorten = shorten.substring 0, shorten.length-1 if shorten.length
  shorten

Boolean.prototype.toStatus = ->
  if @.valueOf()
    console.log "Public"
    "Public"
  else
    console.log "Private"
    "Private"

String.prototype.toLegal = ->
  converters =
    "&": "&amp;"
    "<": "&lt;"
    ">": "&gt;"
    '"': '&quot;'
    "'": '&#39;'
    "/": '&#x2F;'

  String(@).replace /[&<>"'\/]/g, (s) -> converters[s]
