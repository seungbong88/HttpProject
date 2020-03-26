var express = require('express');
var app = express();
 
app.get('/', function (req, res) {
  res.sendFile(__dirname + '/html/index.html');
  console.log('앱 연다아아아');
});

 
var server = app.listen(8000, function () {
  console.log('load Success!');
});

