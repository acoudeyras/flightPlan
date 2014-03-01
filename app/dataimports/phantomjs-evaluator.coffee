'use strict'

phantom = require 'node-phantom'

page = null
ph = null

init = (callback) ->
  return callback(page) if page isnt null

  phantom.create((err,phCreated) ->
    return callback(err) if err

    ph = phCreated
    ph.createPage((err,pageCreated) ->
      return callback(err) if err

      page = pageCreated
      callback()
    )
  )

exports.loadPage = (url, evalCb, resultCb) ->
  init ->
    page.open(url, (err,status) ->
      return callback(err) if err
      
      page.evaluate(evalCb, resultCb)
    )

exports.exit = -> ph.exit()

