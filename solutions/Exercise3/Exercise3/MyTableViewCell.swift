//
//  MyTableViewCell.swift
//  Exercise4
//
//  Created by Ernesto Elsäßer on 06.06.19.
//  Copyright © 2019 Ernesto Elsäßer. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    var isMarked = false
    
    func toggle() {
        isMarked = !isMarked
        label.text = isMarked ? "MARKED" : "unmarked"
    }
}
