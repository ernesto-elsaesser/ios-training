//
//  MyTableViewController.swift
//  Exercise4
//
//  Created by Ernesto Elsäßer on 06.06.19.
//  Copyright © 2019 Ernesto Elsäßer. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    let allRows = Set(arrayLiteral: 0,1,2,3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            self.markRandomCell()
        }
    }
    
    func markRandomCell() {
        
        guard let randomRow = allRows.randomElement() else {
            return
        }
        
        let indexPath = IndexPath(row: randomRow, section: 0)
        
        let cell = tableView.cellForRow(at: indexPath)
        if let myCell = cell as? MyTableViewCell {
            myCell.mark()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        let myCell = cell as? MyTableViewCell
        myCell?.unmark()
    }
}
