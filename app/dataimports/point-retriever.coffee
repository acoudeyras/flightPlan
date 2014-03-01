'use strict'

phantomEval = require './phantomjs-evaluator'

extract =  ->

  airportCategories = ['CAP', 'CAP/Mil']
  vorsCategories = ['VOR', 'VOR/DME', 'VORTAC']

  airportMapping = 
    'Déclinaison': 'declination'
    'Altitude': 'altitude'
    'CONTACTS Téléphoniques': 'phoneContacts'
    'Code Immat. des appareils': 'codeImmat'
    'Code Pays': 'countryCode'
    'Date carte VAC': 'vacMapCreated'
    'Département': 'departement'
    'Frequence App.': 'approachFrequency'
    'Fréquence principale': 'mainFrequency'
    'Informations Contact CARBURANT': 'fuelInfos'
    'Informations PISTES': 'runwayInfos'
    'Localisation radionav.': 'radionavLocalization'
    'Latitude': 'lat'
    'Longitude': 'long'
    'Nom': 'name'
    'Type': 'typeLng'
    'Remarques': 'remarks'
    'Restaurant': 'restaurant'
    'Restaurant N° 1': 'restaurant'
    'Restaurant N° 2': 'restaurant'
    'Hôtel-Restaurant': 'hotelRestaurant'
    'F.I.S.': 'fis'
    'Frequence Sol': 'groundFrequency'
    'Fréquence ATIS': 'frequencyAtis'
    'Téléphone ATIS': 'atisPhone'
    'Afficher la vue SATELLITE\navec Google Maps\n(image de Google Earth)': null
    'Catégorie': null
    'Code': null
    'Créé/Modifié par': null
    'Origine des données': null
    'Region du monde': null

  vorMapping =
    'Date MàJ': 'updated'
    'Code Pays': 'countryCode'
    'Altitude': 'altitude'
    'Déclinaison': 'declination'
    'Fréquence principale': 'frequency'
    'Latitude': 'lat'
    'Longitude': 'long'
    'Nom': 'name'
    'Type': 'typeLng'
    'Afficher la vue SATELLITE\navec Google Maps\n(image de Google Earth)': null
    'Catégorie': null
    'Code': null
    'Créé/Modifié par': null
    'Origine des données': null
    'Region du monde': null


  typeReader = (columns, rowObj) ->
    return if columns.length < 2
    [name, value] = columns
    colName = name.innerText.trim()
    if colName is 'Catégorie'
      rowObj.type = value.innerText.trim()

  colsReader = (mapping) ->
    (columns, rowObj) ->
      return if columns.length < 2
      [name, value] = columns
      name = name.innerText.trim()
      value = value.innerText.trim()
      colName = mapping[name]
      return if colName is null

      if not colName
        rowObj['_' + name] = value
      else
        currentValue = rowObj[colName]
        if not currentValue?
          rowObj[colName] = value
        else
          if Array.isArray currentValue
            currentValue.push value
          else
            rowObj[colName] = [currentValue, value]

  findType = (table) ->
    found = readRows table, 2, typeReader
    found.type

  findReader = (table) ->
    type = findType table
    if vorsCategories.indexOf(type) != -1
      colsReader vorMapping
    else if airportCategories.indexOf(type) != -1
      colsReader airportMapping
    else colsReader {}

  readRows = (table, skip, columnsReader) ->
    result = {}
    rows = table.children[0].children
    skip = skip || 0
    currentRow = -1
    for row in rows
      currentRow++
      continue if currentRow < skip
      columnsReader row.children, result
    result

  table = document.querySelectorAll('table')[0]
  reader = findReader table
  return null if not reader
  readRows table, 2, reader


exports.getPoint = (point, callback) ->

  phantomEval.loadPage(
    point.url,
    extract,
    callback
  )
