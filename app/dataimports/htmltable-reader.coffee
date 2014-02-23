'use strict'

exports.getRows = (table, skip, transform) ->
  return ['ok']
  result = []
  rows = table.children[0].children
  skip = skip || 0
  currentRow = -1
  for row in rows
    currentRow++
    continue if currentRow < skip

    rowObj = transform row.children
    result.push rowObj

  result