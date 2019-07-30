//
//  MyTableViewController.swift
//  Exercise4
//
//  Created by Ernesto Elsäßer on 06.06.19.
//  Copyright © 2019 Ernesto Elsäßer. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    var markedRows: Set<Int> = Set()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath)
        cell.textLabel?.text = "unmarked"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if markedRows.contains(indexPath.row) {
            cell?.textLabel?.text = "unmarked"
            markedRows.remove(indexPath.row)
        } else {
            cell?.textLabel?.text = "MARKED"
            markedRows.insert(indexPath.row)
        }
    }
}
