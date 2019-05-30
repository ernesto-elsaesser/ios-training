//
//  PredefinedCellTableViewController.swift
//  TableViewDemo
//
//  Created by Ernesto Elsäßer on 05.08.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class PredefinedCellTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PredefinedTableViewCell") as! PredefinedTableViewCell
        cell.configure(text: "CELL #\(indexPath.row + 1)")
        
        return cell
    }
}
