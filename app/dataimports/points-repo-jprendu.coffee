'use strict'

phantomEval = require './phantomjs-evaluator'

airportsUrl = 'http://www.jprendu.fr/aeroweb/_private/21_JpRNavMaster/NavMasterSearch.php?SearchMode=V&ButtonType=0&CountryCode=LF&Departement=%&Langue=Fr&Orig=Advanced_Fr&Retry=0&SortedOn=Name&SortDesc=ASC'
vorsUrl = 'http://www.jprendu.fr/aeroweb/_private/21_JpRNavMaster/NavMasterSearch.php?SearchMode=V&ButtonType=5&CountryCode=LF&Departement=NA&Langue=Fr&Orig=Advanced_Fr&Retry=0&SortedOn=Name&SortDesc=ASC'

extractRowsFromPage = ->

  getRows = (table, skip, transform) ->
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

  readUrl = (columnNode) ->
    rootUrl = 'http://www.jprendu.fr/aeroweb/_private/21_JpRNavMaster/'
    link = columnNode.children[0].children[0]
    href = link.outerHTML.split('onclick="window.open(')[1]
    href = href.substring 1, href.length
    href = href.split("',")[0]
    href = href.replace(new RegExp('&amp;', 'g'), '&')
    rootUrl + href

  rowToObj = (columns) ->
    rowJson = {}
    fields = ['country', 'code', 'category', 'info', 'altitude', 'latitude', 'longitude']
    currentColumn = 0

    for column in columns
      field = fields[currentColumn]
      rowJson[field] = column.innerText.trim()
      if field is 'code'
        rowJson.url = readUrl column
      currentColumn++
    rowJson
  
  table = document.querySelectorAll('table')[1]
  getRows(table, 2, rowToObj)

findRows = (url, callback) ->
  phantomEval.loadPage(
    url,
    extractRowsFromPage,
    callback
  )

exports.pointList = (callback) ->
  findRows(airportsUrl, (err, airports) ->
    return callback(err) if err

    findRows(vorsUrl, (err, vors) ->
      return callback(err) if err

      callback null, vors.concat airports
    )
  )





