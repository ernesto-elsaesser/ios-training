//
//  TodoItem.swift
//  NetworkDemo
//
//  Created by Ernesto Elsäßer on 07.06.19.
//  Copyright © 2019 Ernesto Elsaesser. All rights reserved.
//

import Foundation

struct TodoItem: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
