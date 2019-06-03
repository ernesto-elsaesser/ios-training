//
//  ViewController.swift
//  DrawingDemo
//
//  Created by Ernesto Elsäßer on 04.06.19.
//  Copyright © 2019 Ernesto Elsäßer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var renderer: UIGraphicsImageRenderer!
    var currentPath: UIBezierPath?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        renderer = UIGraphicsImageRenderer(size: view.frame.size)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(drawRectangle))
        
        doubleTapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapRecognizer)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: view) else {
            return
        }
        
        let path = UIBezierPath()
        path.move(to: point)
        currentPath = path
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let path = currentPath else {
            return
        }
        
        guard let point = touches.first?.location(in: view) else {
            return
        }
        
        path.addLine(to: point)
        
        let image = renderer.image { ctx in
            
            ctx.cgContext.addPath(path.cgPath)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        currentPath = nil
    }
    
    @objc func drawRectangle(recognizer: UITapGestureRecognizer) {
        
        guard recognizer.state == .ended else {
            return
        }
        
        let point = recognizer.location(in: view)
        let rect = CGRect(origin: point, size: CGSize(width: 15, height: 15))
        
        let image = renderer.image { ctx in
            
            ctx.cgContext.stroke(rect)
            ctx.cgContext.fill(rect)
        }
        
        imageView.image = image
    }

}

