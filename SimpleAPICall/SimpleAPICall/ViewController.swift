//
//  ViewController.swift
//  SimpleAPICall
//
//  Created by Mona Hammad on 12/1/19.
//  Copyright © 2019 Mona Hammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var getResponseLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getCalled(_ sender: Any) {
        getRequest(url: "https://httpbin.org/get") {[weak self] (data, response, error) in
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self?.getResponseLabel.text = dataString
                }
            }
        }
    }
    
    func getRequest(url: String, completion: @escaping (Data?, URLResponse?, Error?)-> Void){
        let url = URL(string: url)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
                completion(nil, nil, error)
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                    completion(data, response, nil)
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
        }
        task.resume()
    }
    
    @IBAction func postCalled(_ sender: Any) {
        let url = URL(string: "https://httpbin.org/post")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
        }
        task.resume()
    }
    
}

