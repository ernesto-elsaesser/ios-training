//
//  ViewController.swift
//  HTTPPOSTDemo
//
//  Created by Ernesto Elsäßer on 01.07.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    let feedbackUrl = URL(string: "http://localhost/feedback")!

    @IBAction func sendFeedback(_ sender: Any) {
        
        var request = URLRequest(url: feedbackUrl)
        
        request.httpMethod = "POST"
        //request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.httpBody = textView.text.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            self?.handleResponse(response: response, error: error)
        }
        task.resume()
    }
    
    func handleResponse(response: URLResponse?, error: Error?) {
        
        if let error = error {
            self.presentError(message: error.localizedDescription)
            return
        }
        
        guard let httpStatus = response as? HTTPURLResponse else {
            self.presentError(message: "Unexpected Error")
            return
        }
        
        guard httpStatus.statusCode == 201 else {
            self.presentError(message: "Unexpected status code: \(httpStatus.statusCode)")
            return
        }
        
        self.presentAlert(title: "Success", message: "Feedback was sent.")
    }
    
    func presentError(message: String) {
        self.presentAlert(title: "Error", message: message)
    }
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

