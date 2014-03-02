'use strict'

exports.extend = (target) ->
  sources = [].slice.call arguments, 1
  sources.forEach (source) ->
    for prop of source
      target[prop] = source[prop]
  target
