String.prototype.shorten = ->
  words = @split ' '

  shorten = ''
  for i in [0...words.length]
    shorten += words[i] + ' ' if words[i]
  shorten = shorten.substring 0, shorten.length-1 if shorten.length
  shorten
