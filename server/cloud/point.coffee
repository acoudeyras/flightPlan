'use strict'

fullText = require 'cloud/full-text.js'

Parse.Cloud.beforeSave 'Point', (request, response) ->
  point = request.object;
  words = fullText.parseWords point, 'code', 'name'

  point.set "words", words
  response.success()