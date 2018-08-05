//
//  ManualTableViewController.swift
//  TableViewDemo
//
//  Created by Ernesto Elsäßer on 02.07.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class ManualTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: view.bounds)
        tableView.register(ManualTableViewCell.self, forCellReuseIdentifier: ManualTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
}

extension ManualTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ManualTableViewCell.reuseIdentifier) as! ManualTableViewCell
        cell.configure(text: "CELL #\(indexPath.row + 1)")
        
        return cell
    }
}
