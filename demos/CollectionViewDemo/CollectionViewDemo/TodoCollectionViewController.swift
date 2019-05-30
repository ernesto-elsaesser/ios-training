//
//  TodoCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Ernesto Elsäßer on 02.07.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class TodoCollectionViewController : UICollectionViewController {
    
    private var todoItems : [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: view.frame.width, height: 40)
        }
        
        collectionView?.register(ProgrammaticCollectionViewCell.self, forCellWithReuseIdentifier: ProgrammaticCollectionViewCell.reuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadTodoItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgrammaticCollectionViewCell.reuseIdentifier, for: indexPath)
        let simpleCell = cell as! ProgrammaticCollectionViewCell
        let item = todoItems[indexPath.item]
        let title = "TODO #\(indexPath.item + 1): \(item.title)"
        simpleCell.configure(title: title)
        return simpleCell
    }
    
    func loadTodoItems() {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        
        let handler = { (data : Data?, response : URLResponse?, error: Error?) in
            
            self.todoItems = self.parseTodoItems(data: data)
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
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
