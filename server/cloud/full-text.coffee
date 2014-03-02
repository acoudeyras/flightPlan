'use strict'

_ = require 'underscore'

toLowerCase = (word) -> word.toLowerCase()

stopWords = ['the', 'in', 'and']

isStopWord = (word) ->
  word.match(/^\w+$/) && ! _.contains(stopWords, word); 

exports.parseWords = (obj, fields...) ->
  words = []
  for field in fields
    val = obj.get field
    continue if not val?
    found = val.split(/\b/)
    words = words.concat found
  words
    .map toLowerCase
    .filter isStopWord