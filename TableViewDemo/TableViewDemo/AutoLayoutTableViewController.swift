//
//  AutoLayoutCollectionViewController.swift
//  TableViewDemo
//
//  Created by Ernesto Elsäßer on 02.07.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class AutoLayoutTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AutoLayoutTableViewCell", for: indexPath) as! AutoLayoutTableViewCell
        cell.pictureView.image = UIImage(named: "monet\(indexPath.item)")
        
        return cell
    }
}
