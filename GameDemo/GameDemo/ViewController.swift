//
//  ViewController.swift
//  GameDemo
//
//  Created by Ernesto Elsäßer on 10.06.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let slotCount = 9
    
    // tuneable parameters
    let initialTimeToNap: TimeInterval = 2
    let minimalTimeToNap: TimeInterval = 0.225
    let speed: Double = 0.1
    
    @IBOutlet var ellapsedTimeLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var startButton: UIButton!
    
    private var allSlots: Set<Int> { return Set(0...(slotCount-1)) }
    private var awakeSlots: Set<Int> = Set()
    private var difficultyLevel = 0.0
    private var timer: Timer?
    
    private func startGame() {
        
        startButton.isEnabled = false
        awakeSlots = allSlots
        difficultyLevel = 0
        ellapsedTimeLabel.textColor = .black
        
        allSlots.map{ self.student(at: $0)! }.forEach{ $0.state = .awake }
        
        self.startTimer()
        self.nextNap()
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
    
    private func nextNap() {
        
        guard let slot = self.randomAwakeSlot() else {
            self.endGame()
            return
        }
        
        let student = self.student(at: slot)!
        student.state = .asleep
        awakeSlots.remove(slot)
        self.scheduleNextNap()
    }
    
    private func scheduleNextNap() {
        
        let variance = initialTimeToNap - minimalTimeToNap
        let secondsUntilNextNap = ((2 * variance) / (1 + pow(M_E,difficultyLevel))) + minimalTimeToNap
        let interval = DispatchTimeInterval.milliseconds(Int(secondsUntilNextNap * 1000))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) { [weak self] in
            self?.nextNap()
        }
    }
    
    fileprivate func rebuke(slot: Int) {
        
        guard timer != nil, let student = self.student(at: slot) else {
            return
        }
        
        switch student.state {
        case .asleep:
            student.state = .awake
            awakeSlots.insert(slot)
        case .awake:
            student.state = .angry
            awakeSlots.remove(slot)
        case .angry:
            break
        }
        
        difficultyLevel += speed
    }
    
    private func endGame() {
        
        timer?.invalidate()
        timer = nil
        ellapsedTimeLabel.textColor = .red
        startButton.isEnabled = true
    }
    
    private func student(at slot: Int) -> StudentCollectionViewCell? {
        let indexPath = IndexPath(item: slot, section: 0)
        return collectionView.cellForItem(at: indexPath) as? StudentCollectionViewCell
    }
    
    private func randomAwakeSlot() -> Int? {
        guard !awakeSlots.isEmpty else {
            return nil
        }
        let array = Array(awakeSlots)
        let index = Int(arc4random_uniform(UInt32(array.count)))
        return array[index]
    }

    @IBAction func startTapped(_ sender: Any) {
        self.startGame()
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slotCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: StudentCollectionViewCell.reuseIdentifier,
                                                  for: indexPath) as! StudentCollectionViewCell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.rebuke(slot: indexPath.item)
    }
}

