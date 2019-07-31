//
//  ViewController.swift
//  AnimationDemo
//
//  Created by Ernesto Elsäßer on 31.07.19.
//  Copyright © 2019 Ernesto Elsäßer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBAction func animateFrameTapped(_ sender: Any) {
        
        var newFrame = label.frame
        newFrame.origin.y += 150
        
        UIView.animate(withDuration: 3) {
            self.label.frame = newFrame
        }
    }
    
    @IBAction func animateConstraintTapped(_ sender: Any) {
        
        topConstraint.constant += 150
        
        UIView.animate(withDuration: 3) {
            self.view.layoutIfNeeded()
        }
    }
}

