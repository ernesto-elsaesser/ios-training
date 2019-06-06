//
//  ViewController.swift
//  Exercise2
//
//  Created by Ernesto Elsäßer on 06.06.19.
//  Copyright © 2019 Ernesto Elsäßer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    @IBAction func startTapped(_ sender: Any) {
        let r = Int.random(in: 0...2)
        
        let button: UIButton
        switch r {
        case 0: button = button1
        case 1: button = button2
        case 2: button = button3
        default: return
        }
        
        button.backgroundColor = .orange
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.backgroundColor = .clear
    }
}

