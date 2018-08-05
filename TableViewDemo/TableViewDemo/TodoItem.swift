//
//  TodoItem.swift
//  CollectionViewDemo
//
//  Created by Ernesto Elsäßer on 02.07.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import Foundation

struct TodoItem: Codable {
    
    //let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
