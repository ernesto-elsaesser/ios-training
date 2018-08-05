//
//  ManualTableViewCell.swift
//  TableViewDemo
//
//  Created by Ernesto Elsäßer on 05.08.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class ManualTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ManualTableViewCell"

    func configure(text: String) {
        textLabel?.text = text
    }
}
