//
//  StudentCollectionViewCell.swift
//  NappyNap
//
//  Created by Ernesto Elsäßer on 10.06.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class StudentCollectionViewCell: UICollectionViewCell {
    
    enum State: String {
        case awake = "🙂"
        case asleep = "😴"
        case angry = "😡"
    }
    
    @IBOutlet var label: UILabel!
    
    var state: State = .awake {
        didSet {
            label.text = state.rawValue
        }
    }
}
