//
//  TodoTableViewCell.swift
//  TableViewDemo
//
//  Created by Ernesto Elsäßer on 05.08.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    @IBOutlet var doneSwitch: UISwitch!
    
    func load(todoItem: TodoItem) {
        label.text = todoItem.title
        doneSwitch.isOn = todoItem.completed
    }
}
