//
//  TableViewController.swift
//  TableViewDemo
//
//  Created by Ernesto Elsäßer on 02.07.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let existingCell = tableView.dequeueReusableCell(withIdentifier: "ANYTHING")
        let cell = existingCell ?? UITableViewCell(style: .default, reuseIdentifier: "ANYTHING")
        
        cell.textLabel?.text = "CELL #\(indexPath.item)"
        
        return cell
    }
}
