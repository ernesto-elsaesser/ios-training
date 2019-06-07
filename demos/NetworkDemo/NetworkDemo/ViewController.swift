//
//  ViewController.swift
//  NetworkDemo
//
//  Created by Ernesto Elsäßer on 01.07.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let downloadUrl = URL(string: "https://jsonplaceholder.typicode.com/todos")!

    @IBAction func downloadBlockingTapped(_ sender: Any) {
        
        do {
            let jsonData = try Data(contentsOf: downloadUrl)
            self.parse(data: jsonData)
        } catch {
            self.alertOnMainQueue("Network request failed!")
        }
    }

    @IBAction func downloadNonBlockingTapped(_ sender: Any) {

        let request = URLRequest(url: downloadUrl)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                self.parse(data: data)
            } else {
                self.alertOnMainQueue("Network request failed!")
            }
        }
        task.resume()
    }
    
    func parse(data: Data) {

        let decoder = JSONDecoder()
        do {
            let todos = try decoder.decode([TodoItem].self, from: data)
            self.alertOnMainQueue("Loaded \(todos.count) TODO items!")
        } catch {
            self.alertOnMainQueue("Parsing failed!")
        }
    }
    
    func alertOnMainQueue(_ message: String) {
        
        let alertController = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

