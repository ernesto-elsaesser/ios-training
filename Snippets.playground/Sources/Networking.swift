//
//  NetworkCaller.swift
//  Prep
//
//  Created by Ernesto Elsäßer on 12/03/2017.
//  Copyright © 2017 DHBW. All rights reserved.
//

import Foundation

public class DataLoader {
    
    public init() {}
    
    public func loadZen() -> String? {
        
        guard let url = URL(string: "https://api.github.com/zen") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}
