//
//  NappyNapViewController.swift
//  NappyNap
//
//  Created by Ernesto Elsäßer on 10.06.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class NappyNapViewController: UIViewController {

    let itemCount = 9
    
    // tuneable parameters
    let initialTimeToNap: TimeInterval = 2
    let minimalTimeToNap: TimeInterval = 0.225
    let speed: Double = 0.1
    
    @IBOutlet var ellapsedTimeLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var startButton: UIButton!
    
    private var awakeIndexPaths: Set<IndexPath> = Set()
    private var difficultyLevel = 0.0
    private var timer: Timer?
    
    private var allIndexPaths: Set<IndexPath> {
        var set = Set<IndexPath>()
        for item in 0..<itemCount {
            let indexPath = IndexPath(item: item, section: 0)
            set.insert(indexPath)
        }
        return set
    }
    
    private func startGame() {
        
        startButton.isEnabled = false
        awakeIndexPaths = allIndexPaths
        difficultyLevel = 0
        ellapsedTimeLabel.textColor = .black
        
        self.resetCells()
        self.startTimer()
        self.boreRandomStudentToSleep()
    }
    
    private func resetCells() {
        
        for indexPath in allIndexPaths {
            if let cell = collectionView.cellForItem(at: indexPath) as? StudentCollectionViewCell {
                cell.state = .awake
            }
        }
    }
    
    private func startTimer() {
        
        let start = Date()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            let ellapsedTime = Date().timeIntervalSince(start)
            let minutes = Int(ellapsedTime) / 60
            let seconds = Int(ellapsedTime) - (minutes * 60)
            self?.ellapsedTimeLabel.text = String(format: "%02i:%02i", minutes, seconds)
        }
    }
    
    private func boreRandomStudentToSleep() {
        
        guard let indexPath = self.randomAwakeIndexPath() else {
            self.endGame()
            return
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? StudentCollectionViewCell else {
            return
        }
        
        cell.state = .asleep
        awakeIndexPaths.remove(indexPath)
        
        self.scheduleNextNap()
    }
    
    private func randomAwakeIndexPath() -> IndexPath? {
        guard !awakeIndexPaths.isEmpty else {
            return nil
        }
        let array = Array(awakeIndexPaths)
        let index = Int(arc4random_uniform(UInt32(array.count)))
        return array[index]
    }
    
    private func scheduleNextNap() {
        
        let variance = initialTimeToNap - minimalTimeToNap
        let secondsUntilNextNap = ((2 * variance) / (1 + pow(M_E,difficultyLevel))) + minimalTimeToNap
        
        Timer.scheduledTimer(withTimeInterval: secondsUntilNextNap, repeats: false) { [weak self] _ in
            self?.boreRandomStudentToSleep()
        }
    }
    
    fileprivate func rebuke(indexPath: IndexPath) {
        
        guard timer != nil else {
            return // not started
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? StudentCollectionViewCell else {
            return
        }
        
        switch cell.state {
        case .asleep:
            cell.state = .awake
            awakeIndexPaths.insert(indexPath)
        case .awake:
            cell.state = .angry
            awakeIndexPaths.remove(indexPath)
        case .angry:
            break
        }
    }
    
    private func endGame() {
        
        timer?.invalidate()
        timer = nil
        ellapsedTimeLabel.textColor = .red
        startButton.isEnabled = true
    }

    @IBAction func startTapped(_ sender: Any) {
        self.startGame()
    }
}

extension NappyNapViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "StudentCollectionViewCell", for: indexPath)
    }
}

extension NappyNapViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.rebuke(indexPath: indexPath)
        difficultyLevel += speed
    }
}

