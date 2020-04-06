//
//  ViewController.swift
//  HttpTest
//
//  Created by seungbong on 2020/03/23.
//  Copyright © 2020 한승희. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }


    @IBAction func clickedTransferBtn(_ sender: Any) {
        
        sendJsonData(message: textField.text!)
    }
    @IBAction func clickedResponseBtn(_ sender: Any) {
        
    }
    
    // 서버로 json 데이터 보내기
    func sendJsonData (message: String) {
        let dic: Dictionary = ["message": message]
        
        guard let url = URL(string: "http://localhost:3000") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do { // request body에 전송할 데이터 넣기
            request.httpBody = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        } catch {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            // 데이터 수신
            
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
        
    }
    
    
    
    @IBAction func sendDataWithAlamofire(_ sender: Any) {
        
        let param = ["message": self.textField.text]
        
        guard let url = URL(string: "http://localhost:3000") else {
            return
        }
        
        AF.request(url,
                   method: .post,
                   parameters: param,
                   encoder: JSONParameterEncoder.default,
                   headers: ["Content-Type": "application/json", "Accept-Type":"application/json"],
                   interceptor: nil)
            .response { response in
                print(response)
            }
        
    }
    
}


