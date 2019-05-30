//
//  PredefinedTableViewCell.swift
//  TableViewDemo
//
//  Created by Ernesto Elsäßer on 05.08.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class PredefinedTableViewCell: UITableViewCell {

    @IBOutlet var customLabel: UILabel!

    func configure(text: String) {
        customLabel.text = text
    }
}
