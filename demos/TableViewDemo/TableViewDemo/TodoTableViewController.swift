//
//  TodoTableViewController.swift
//  TableViewDemo
//
//  Created by Ernesto Elsäßer on 02.07.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class TodoTableViewController : UITableViewController {
    
    private var todoItems : [TodoItem] = []

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadTodoItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell") as! TodoTableViewCell
        let item = todoItems[indexPath.item]
        cell.load(todoItem: item)
        
        return cell
    }
    
    func loadTodoItems() {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        
        let handler = { (data : Data?, response : URLResponse?, error: Error?) in
            
            // Error handling should go here
            
            self.todoItems = self.parseTodoItems(data: data)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: handler)
        task.resume()
    }
    
    func parseTodoItems(data: Data?) -> [TodoItem] {
        
        guard let json = data else {
            print("RECEIVED EMPTY DATA")
            return []
        }
        
        let decoder = JSONDecoder()
        
        do {
            let decodedItems = try decoder.decode([TodoItem].self, from: json)
            return decodedItems
        } catch {
            print("RECEIVED INVALID DATA: \(error)")
            return []
        }
    }
}
