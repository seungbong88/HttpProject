# HttpProject
ios - http 통신 프로젝트







## 1. 서버에 데이터 송신하기 (iOS -> Node.js)



먼저 URLSession을 이용해 json Data를 서버로 보내는 예제를 진행해보았다.



> URLSession 이란?

- URLSession이란 HTTP를 포함한 여러 통신을 하는 필요한 기능을 제공해주는 객체라고 볼 수 있다.

- 이 URLSession을 이용한 것이 `Alamofire` , `AFNetworking` 라이브러리 등이 있다.

  (*URLSession을 이용해 직접 통신을 구현해 본 다음 `Alamofire` 라이브러리를 이용해 간단하게 통신하는 방법을 배워볼 것이다.*)

- http 통신이 request와 response로 이루어진 것 처럼, `URLRequest` , `URLResponse`를 이용해 데이터 송수신이 가능하다.



버튼을 눌러 텍스트필드의 데이터를 서버에 보내는 예제를 간단하게 구현해보았다.
텍스트필드에 데이터를 입력하고 '데이터 전송' 버튼을 누르면 서버에 텍스트필드의 데이터가 전송되는 방법이다. 
결과화면은 아래와 같다.

![1](/Users/bong/Desktop/1.png)







1. 서버에 보낼 데이터를 dictionay 형태로 저장한다.

   - 여기서는 텍스트 필드에 넣은 데이터에 임의의 key 값을 붙여 간단하게 만들었다.

   ```swift
   let dic: Dictionary = ["message": message]	// 서버로 보낼 데이터
   ```

2. 데이터를 보낼 url을 설정하고, 이 url로 `URLRequest` 를 정의한다.

   - `URLRequest` 란?

     - 프로토콜이나 URL Scheme에 독립적인 URL 로드 request 방식

       ```swift
       URLRequest는 두 개의 필수적인 url load 요소로 캡슐화 되어있다. 이는 로드되는 url과 이를 로드할 때 사용하는 정책이다. HTTP와 HTTPS 요청에 대해서 URLRequestsms HTTP 메서드(GET, POST 등)와 HTTP 헤더를 가지고 있다.
       URLRequest는 오직 요청에 대한 정보만을 나타낸다. 'URLSsession'과 같은 다른 클래스들을 사용하여 서버에 데이터를 보낸다. 
       swift 코드를 사용할 때에는 'NSURLRequest'나 'NSMutableURLRequest' 클래스보다 이 구조를 선호하여 사용하라.
       [출처 : Apple Developer Documentation]
       ```

       -> 설명에 나와있는 것 처럼 `URLRequest` 는 요청을 보내는 것에 대한 정보만을 가지고 있으며, 실제로 이를 서버에 전송하는 것은 `URLSession` 이 담당한다.

       

   ```swift
   		guard let url = URL(string: "http://localhost:3000") else {
   				return	// 데이터를 보낼 서버 url
   		}
                   
   		var request = URLRequest(url: url)
   		request.httpMethod = "POST"	 	// http 메서드는 'POST'
           
   		do { // request body에 전송할 데이터 넣기
   				request.httpBody = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
   		} catch {
   				print(error.localizedDescription)
   		}
           
   		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
   		request.addValue("application/json", forHTTPHeaderField: "Accept-Type")
           
   ```

   - URLRequest의 바디를 설정하는 부분에는 `JSONSerializtion`  객체를 이용하였는데, 이것은 Foundation에서 제공하는 데이터를 json 데이터로 변경해주는 역할을 한다.

   - 하단의 `request.addValue` 는 POST 방식으로 데이터를 보낼 때 추가해주는 것이다.

     ```swift'
     Content-Type 과 Accept-Type 은 서버와 데이터를 주고 받을 때 그 데이터의 형식에 대해 명시하는 것 같다.
     ```



3. `URLSession` 을 이용해 데이터를 서버에 보낸다.

   ```swift
   let session = URLSession.shared
   session.dataTask(with: request, completionHandler: { (data, response, error) in
   		print("전송완료")
   }).resume()
   ```

   - `URLSession` 이란?

     - 관련 네트워크에 데이터를 전송하는 작업을 하는 객체

     ```swift
     URLSession 및 관련 클래스들은 특정된 URL에 데이터를 다운로드하거나 업로드하는 API를 제공한다.
     당신의 앱은 또한 이 API를 이용해 백그라운드 다운로드 작업을 진행할 수 있다. 당신의 앱이 실행되고 있지 않거나 suspend 상태일 때도 말이다. 당신은 이와 관련된 URLSessionDelegate와 URLSEssionTaskDelegate를 이용해 redirection과 같은 이벤트를 받거나 작업이 끝났음을 알 수 있다.
     
     당신의 앱은 하나나 그 이상의 URLSession 인스턴스를 생성하며 이것들 각각은 관련된 전송 데이터 작업들을 조정한다. 예를 들어, 당신이 웹브라우저를 만든다면 당신의 앱은 아마 각 탭이나 윈도우마다 하나의 세션을 만들것이다. 이 각각의 세션 안에서 당신의 앱은 일련의 작업들을 추가할 것이고, 이것들은 특정 URL에 대한 요청을 가리킨다. 
     
     [Type of URL SEssions]
     URLSession은 하나의 싱글턴 객체를 사용하며, 그 종류는 세 가지가 있다.
     1) default session 
     2) ephemeral session
     3) background session
     ```



이대로 실행하면 아래와 같이 에러에 대한 설명이 나온다.

![image-20200323232636325](file:///Users/bong/Library/Application%20Support/typora-user-images/image-20200323232636325.png?lastModify=1585233766?lastModify=1585321211)

- 읽어보면 ~~ Trnasport Security policy requires~~ 이렇게 나오는데, 이는 https을 표준으로 사용하는 Xcode에서 http 로 시작하는 페이지에 대해 허용해주지 않아서 발생하는 에러임을 알 수 있다. 

- 이를 해결하기 위해서는 info.plist에 다음 딕셔너리를 추가해주어야 한다.

  ![image-20200323232847894](file:///Users/bong/Library/Application%20Support/typora-user-images/image-20200323232847894.png?lastModify=1585233766?lastModify=1585321211)



설정해주면 데이터 전송을 확인할 수 있다!







## 2. 서버에서 Post 로 데이터 수신하기

*위에서는 앱에서 서버로 데이터를 보냈고, 서버에도 데이터를 받을 수 있는 코드가 있어야지 제대로 전송되어있음을 확인할 수 있다. 이전과 마찬가지로 서버는 node.js로 구현하였고, 데이터 수신을 위한 최소한의 코드만 작성하였다.*

```javascript
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
```

- node.js에서 express를 이용하는 POST 통신 방법은 GET 방식과 다르게 `body-parser` 라는 모듈을 추가로 사용해 주어야 한다.

- `app.listen(port, func(){ })` 은 해당 포트로 들어오는 데이터를 읽는 부분이다.

- `app.post()` 와 같은 방법을 이용하면, req 파라미터에 http 통신으로 들어온 데이터가 저장되게 된다. 
  Header / body 중 데이터는 body 에 들어가므로,  콘솔에 body를 출력하면 앱에서 보낸 json 데이터를 확인할 수 있다.







---

### 서버에서 데이터 받기 (Node.js -> iOS)

*많은 작업을 해줘야 되는 줄 알았는데 생각보다 간단했다.*

1. Node.js

   ```javascript
   // post method connect
   app.post('/', function (req, res) {
       console.log('post 메서드 받음 ')
       console.log(req.body);
   
       res.send({ status: 'SUCCESS' });
   });
   ```

   - res.send() 메서드만 추가해주면 된다.
     이때, 파라미터는 json 데이터를 넣어야 앱에서 json 형태로 받을 수 있음

2. iOS

   ```swift
   session.dataTask(with: request, completionHandler: { (data, response, error) in
               
   	if error != nil {
   		print(error?.localizedDescription)
   		return
   	}
               
   	do {
   		let resultData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
   		print(resultData)
   	} catch {
   		print(error.localizedDescription)
   	}
   }).resume()
   ```

   - 별다른 소스코드 추가해줄 필요 없이 저 `session.dataTask` 메서드의 `data` 부분에 서버에서 보내는 데이터가 저장됨

   ![image-20200329001902314](/Users/bong/Library/Application Support/typora-user-images/image-20200329001902314.png)