//
//  Loader.swift
//  Demo
//
//  Created by Ernesto Elsäßer on 20/03/2017.
//  Copyright © 2017 DHBW. All rights reserved.
//

import Foundation

class Loader {
    
    static func getTodos(completion: @escaping (([String]) -> Void)) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
            return
        }
        
        let handler = { (data : Data?, response : URLResponse?, error: Error?) in
            
            guard let mydata = data else {
                return // error handling
            }
            
            guard let object = try? JSONSerialization.jsonObject(with: mydata, options: []) else {
                    return
            }
            
            guard let castedObject = object as? [[String:Any]] else {
                return
            }
            
            var titles = [String]()
            
            for entry in castedObject {
                if let title = entry["title"] as? String {
                    titles.append(title)
                }
            }
            
            DispatchQueue.main.async {
                completion(titles)
            }
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: handler)
        
        task.resume()
    }
    
    static func getTodosSync() -> [String]? {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
            return nil
        }
        
        guard let mydata = try? Data(contentsOf: url) else {
            return nil
        }
        
        guard let object = try? JSONSerialization.jsonObject(with: mydata, options: []) else {
            return nil
        }
        
        guard let castedObject = object as? [[String:Any]] else {
            return nil
        }
        
        var titles = [String]()
        
        for entry in castedObject {
            if let title = entry["title"] as? String {
                titles.append(title)
            }
        }
        
        return titles
    }
}


/*
 
 DispatchQueue.main.async {
 
 }
 */
