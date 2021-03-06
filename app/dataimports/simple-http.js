// Generated by CoffeeScript 1.6.2
(function() {
  'use strict';
  var http;

  http = require('http');

  exports.request = function(options, callback) {
    var req, returnError;

    returnError = function(err) {
      return callback(err);
    };
    req = http.request(options, function(res) {
      var html;

      if (res.statusCode !== 200) {
        return returnError(res);
      }
      res.setEncoding('utf8');
      html = '';
      res.on('data', function(chunk) {
        return html += chunk;
      });
      return res.on('end', function() {
        return callback(null, html);
      });
    });
    req.on('error', returnError);
    return req.end();
  };

}).call(this);
