//
//  ViewController.swift
//  UserDefaultsDemo
//
//  Created by Ernesto Elsäßer on 05.06.19.
//  Copyright © 2019 Ernesto Elsäßer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let savedNameKey = "UserDefaultsDemoSavedName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = UserDefaults.standard.string(forKey: savedNameKey)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        nameLabel.text = textField.text
        UserDefaults.standard.set(textField.text, forKey: savedNameKey)
        textField.text = nil
    }
}

