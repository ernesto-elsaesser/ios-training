//
//  GameViewController.swift
//  GameDemo
//
//  Created by Ernesto Elsäßer on 10.06.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    let rowCount = 7
    
    // tuneable parameters
    let initialTimeUntilMarking: TimeInterval = 2
    let minimalTimeUntilMarking: TimeInterval = 0.225
    let speed: Double = 0.1
    
    @IBOutlet var ellapsedTimeLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var startButton: UIButton!
    
    private var unmarkedIndexPaths: Set<IndexPath> = Set()
    private var difficultyLevel = 0.0
    private var timer: Timer?
    
    private var allIndexPaths: Set<IndexPath> {
        var set = Set<IndexPath>()
        for row in 0..<rowCount {
            let indexPath = IndexPath(row: row, section: 0)
            set.insert(indexPath)
        }
        return set
    }
    
    private func startGame() {
        
        startButton.isEnabled = false
        unmarkedIndexPaths = allIndexPaths
        difficultyLevel = 0
        ellapsedTimeLabel.textColor = .black
        
        self.resetCells()
        self.startTimer()
        self.markRandomSlot()
    }
    
    private func resetCells() {
        
        for indexPath in allIndexPaths {
            if let cell = tableView.cellForRow(at: indexPath) as? MarkableTableViewCell {
                cell.marked = false
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
    
    private func markRandomSlot() {
        
        guard let indexPath = self.randomUnmarkedIndexPath() else {
            self.endGame()
            return
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? MarkableTableViewCell else {
            return
        }
        
        cell.marked = true
        unmarkedIndexPaths.remove(indexPath)
        
        self.scheduleNextMarking()
    }
    
    private func randomUnmarkedIndexPath() -> IndexPath? {
        
        guard !unmarkedIndexPaths.isEmpty else {
            return nil
        }
        let array = Array(unmarkedIndexPaths)
        let index = Int(arc4random_uniform(UInt32(array.count)))
        return array[index]
    }
    
    private func scheduleNextMarking() {
        
        let variance = initialTimeUntilMarking - minimalTimeUntilMarking
        let secondsUntilNextMarking = ((2 * variance) / (1 + pow(M_E,difficultyLevel))) + minimalTimeUntilMarking
        let interval = DispatchTimeInterval.milliseconds(Int(secondsUntilNextMarking * 1000))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) { [weak self] in
            self?.markRandomSlot()
        }
    }
    
    fileprivate func unmark(indexPath: IndexPath) {
        
        guard timer != nil else {
            return // not started
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? MarkableTableViewCell, cell.marked else {
            return
        }
        
        unmarkedIndexPaths.insert(indexPath)
        cell.marked = false
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

extension GameViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / CGFloat(rowCount)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "MarkableTableViewCell", for: indexPath)
    }
}

extension GameViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.unmark(indexPath: indexPath)
        difficultyLevel += speed
    }
}

