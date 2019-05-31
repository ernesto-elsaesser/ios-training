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
    
    let downloadUrl = URL(string: "https://jsonplaceholder.typicode.com/todos")!

    @IBAction func downloadSyncTapped(_ sender: Any) {
        
        do {
            let jsonData = try Data(contentsOf: downloadUrl)
            self.parse(data: jsonData)
        } catch {
            self.presentError(error)
            return
        }
    }

    @IBAction func downloadAsyncTapped(_ sender: Any) {

        let request = URLRequest(url: downloadUrl)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let data = data {
                self?.parse(data: data)
            } else if let error = error {
                self.presentError(error)
            }
        }
        task.resume()
    }
    
    func parse(data: Data) {
        // TODO: implement
    }
    
    func presentError(_ error: Error) {
        self.presentAlert(title: "Error", message: error.localizedDescription)
    }
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

