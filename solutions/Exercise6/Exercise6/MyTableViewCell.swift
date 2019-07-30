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
    
    func mark() {
        label.text = "MARKED"
    }
    
    func unmark() {
        label.text = "unmarked"
    }
}
