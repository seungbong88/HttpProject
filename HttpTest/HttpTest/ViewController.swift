//
//  ViewController.swift
//  HttpTest
//
//  Created by seungbong on 2020/03/23.
//  Copyright © 2020 한승희. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }


    @IBAction func clickedTransferBtn(_ sender: Any) {
        
        sendJsonData(message: textField.text!)
    }
   
    // 서버로 json 데이터 보내기
    func sendJsonData (message: String) {
        let dic: Dictionary = ["message": message]
        
        guard let url = URL(string: "http://localhost:3000") else {
            return
        }
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do { // request body에 전송할 데이터 넣기
            request.httpBody = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        } catch {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept-Type")
        
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            print("dataTask ㅇㅅㅇ")
            }).resume()
        
    }
    
}


