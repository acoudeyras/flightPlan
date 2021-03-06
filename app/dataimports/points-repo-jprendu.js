// Generated by CoffeeScript 1.6.2
'use strict';
var airportsUrl, extractRowsFromPage, findRows, phantomEval, vorsUrl;

phantomEval = require('./phantomjs-evaluator');

airportsUrl = 'http://www.jprendu.fr/aeroweb/_private/21_JpRNavMaster/NavMasterSearch.php?SearchMode=V&ButtonType=0&CountryCode=LF&Departement=%&Langue=Fr&Orig=Advanced_Fr&Retry=0&SortedOn=Name&SortDesc=ASC';

vorsUrl = 'http://www.jprendu.fr/aeroweb/_private/21_JpRNavMaster/NavMasterSearch.php?SearchMode=V&ButtonType=5&CountryCode=LF&Departement=NA&Langue=Fr&Orig=Advanced_Fr&Retry=0&SortedOn=Name&SortDesc=ASC';

extractRowsFromPage = function() {
  var getRows, readUrl, rowToObj, table;

  getRows = function(table, skip, transform) {
    var currentRow, result, row, rowObj, rows, _i, _len;

    result = [];
    rows = table.children[0].children;
    skip = skip || 0;
    currentRow = -1;
    for (_i = 0, _len = rows.length; _i < _len; _i++) {
      row = rows[_i];
      currentRow++;
      if (currentRow < skip) {
        continue;
      }
      rowObj = transform(row.children);
      result.push(rowObj);
    }
    return result;
  };
  readUrl = function(columnNode) {
    var href, link, rootUrl;

    rootUrl = 'http://www.jprendu.fr/aeroweb/_private/21_JpRNavMaster/';
    link = columnNode.children[0].children[0];
    href = link.outerHTML.split('onclick="window.open(')[1];
    href = href.substring(1, href.length);
    href = href.split("',")[0];
    href = href.replace(new RegExp('&amp;', 'g'), '&');
    return rootUrl + href;
  };
  rowToObj = function(columns) {
    var column, currentColumn, field, fields, rowJson, _i, _len;

    rowJson = {};
    fields = ['country', 'code', 'category', 'info', 'altitude', 'latitude', 'longitude'];
    currentColumn = 0;
    for (_i = 0, _len = columns.length; _i < _len; _i++) {
      column = columns[_i];
      field = fields[currentColumn];
      rowJson[field] = column.innerText.trim();
      if (field === 'code') {
        rowJson.url = readUrl(column);
      }
      currentColumn++;
    }
    return rowJson;
  };
  table = document.querySelectorAll('table')[1];
  return getRows(table, 2, rowToObj);
};

findRows = function(url, callback) {
  return phantomEval.loadPage(url, extractRowsFromPage, callback);
};

exports.pointList = function(callback) {
  return findRows(airportsUrl, function(err, airports) {
    if (err) {
      return callback(err);
    }
    return findRows(vorsUrl, function(err, vors) {
      if (err) {
        return callback(err);
      }
      return callback(null, vors.concat(airports));
    });
  });
};
