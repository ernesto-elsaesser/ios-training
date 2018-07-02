//
//  AutoLayoutCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Ernesto Elsäßer on 02.07.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class AutoLayoutCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: view.frame.width, height: 100)
        }
        
        collectionView?.register(AutoLayoutCollectionViewCell.self, forCellWithReuseIdentifier: AutoLayoutCollectionViewCell.reuseIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AutoLayoutCollectionViewCell.reuseIdentifier, for: indexPath) as! AutoLayoutCollectionViewCell
        cell.image = UIImage(named: "monet\(indexPath.item)")
        return cell
    }
}
