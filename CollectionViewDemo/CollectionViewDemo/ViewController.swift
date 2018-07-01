//
//  ViewController.swift
//  SingleColumnCollection
//
//  Created by Ernesto Elsäßer on 10.06.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let layout = UICollectionViewFlowLayout()
        
        
        layout.itemSize = CGSize(width: view.frame.width, height: 40)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        
        collectionView?.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath)
    }
}
