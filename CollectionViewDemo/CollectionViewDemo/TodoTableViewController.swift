//
//  TodoTableViewController.swift
//  Demo
//
//  Created by Ernesto Elsäßer on 20/03/2017.
//  Copyright © 2017 DHBW. All rights reserved.
//

import UIKit

class TodoTableViewController : UITableViewController {
    
    private var todos : [String] = []
    
    func updateTodos(todos: [String]) {
        self.todos = todos
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = todos[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
