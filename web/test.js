
var express  = require('express');  // express framework 사용
var hostname = '172.30.1.28';       // localhost
var port     = 3000;                // 포트 번호
var http     = require('http');     // node 내장 모듈 불러옴

var app = express();
var bodyParser = require('body-parser')     // post 사용을 위한 모듈
app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());


console.log('Server running at http://'+hostname+':'+port);


// 들어오는 데이터 읽기
var server = app.listen(port, function () {
    console.log('읽음');
});


// post method connect
app.post('/', function (req, res) {
    console.log('post 메서드 받음 ')
    console.log(req.body)
});
