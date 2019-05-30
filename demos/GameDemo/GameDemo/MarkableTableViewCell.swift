//
//  MarkableTableViewCell.swift
//  GameDemo
//
//  Created by Ernesto Elsäßer on 10.06.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class MarkableTableViewCell: UITableViewCell {
    
    var marked: Bool = false {
        didSet {
            backgroundColor = marked ? .red : .green
        }
    }
}
