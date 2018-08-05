//
//  ManualCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Ernesto Elsäßer on 02.07.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class ManualCollectionViewController: UIViewController {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: 40)
        layout.minimumLineSpacing = 1
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(white: 0.92, alpha: 1)
        collectionView.dataSource = self
        
        collectionView.register(ProgrammaticCollectionViewCell.self, forCellWithReuseIdentifier: ProgrammaticCollectionViewCell.reuseIdentifier)
        
        view.addSubview(collectionView)
    }
}

extension ManualCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgrammaticCollectionViewCell.reuseIdentifier, for: indexPath)
        let simpleCell = cell as! ProgrammaticCollectionViewCell
        simpleCell.configure(title: "CELL #\(indexPath.item)")
        return simpleCell
    }
}
