'use strict'

phantom = require 'node-phantom'

exports.loadPage = (url, evalCb, resultCb) ->
  phantom.create((err,ph) ->
    return callback(err) if err

    ph.createPage((err,page) ->
      return callback(err) if err

      page.open(url, (err,status) ->
        return callback(err) if err
        
        page.evaluate evalCb, (err,result) ->
          ph.exit()
          resultCb err, result
      )
    )
  )