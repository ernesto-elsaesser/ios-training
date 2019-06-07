//
//  ViewController.swift
//  ParsingDemo
//
//  Created by Ernesto Elsäßer on 01.07.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

struct Todo: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

class ViewController: UIViewController {
    
    let downloadUrl = URL(string: "https://jsonplaceholder.typicode.com/todos")!
    let decoder = JSONDecoder()

    @IBAction func downloadSyncTapped(_ sender: Any) {
        
        do {
            let jsonData = try Data(contentsOf: downloadUrl)
            self.parse(data: jsonData)
        } catch {
            self.presentError(error)
        }
    }

    @IBAction func downloadAsyncTapped(_ sender: Any) {

        let request = URLRequest(url: downloadUrl)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let data = data {
                self?.parse(data: data)
            } else if let error = error {
                self?.presentError(error)
            }
        }
        task.resume()
    }
    
    func parse(data: Data) {

        do {
            let todos = try decoder.decode([Todo].self, from: data)
            self.presentAlert(title: "Success", message: "Loaded \(todos.count) todos!")
        } catch {
            self.presentError(error)
        }
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

