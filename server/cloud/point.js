// Generated by CoffeeScript 1.7.1
'use strict';
var fullText;

fullText = require('cloud/full-text.js');

Parse.Cloud.beforeSave('Point', function(request, response) {
  var point, words;
  point = request.object;
  words = fullText.parseWords(point, 'code', 'name');
  point.set("words", words);
  return response.success();
});