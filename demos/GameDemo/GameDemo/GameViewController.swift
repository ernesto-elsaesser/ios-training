//
//  GameViewController.swift
//  GameDemo
//
//  Created by Ernesto Elsäßer on 10.06.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    // adjustable parameters
    let initialTimeUntilMarking: TimeInterval = 2
    let minimalTimeUntilMarking: TimeInterval = 0.45
    let rowCount = 7
    let speed: Double = 0.1
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var startButton: UIButton!
    
    private var unmarkedRows: [Int] = []
    private var difficultyLevel = 0.0
    
    @IBAction func startTapped(_ sender: Any) {
        self.startGame()
    }
    
    private func startGame() {
        unmarkedRows.removeAll()
        for row in 0..<rowCount {
            unmarkedRows.append(row)
            self.markableCell(in: row)?.marked = false
        }
        
        startButton.isEnabled = false
        difficultyLevel = 0
        
        self.startTimer()
        self.markNextRow()
    }
    
    private func markNextRow() {
        self.markRandomRow()
        
        if unmarkedRows.isEmpty {
            self.endGame()
        } else {
            let interval = self.currentTimeUntilMarkingInMilliseconds()
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(interval)) {
                self.markNextRow()
            }
        }
    }
    
    private func markRandomRow() {
        let randomIndex = Int.random(in: unmarkedRows.indices)
        let randomRow = unmarkedRows[randomIndex]
        unmarkedRows.remove(at: randomIndex)
        self.markableCell(in: randomRow)?.marked = true
    }
    
    private func currentTimeUntilMarkingInMilliseconds() -> Int {
        // let the time shrink logistically towards the lower limit (sigmoid curve)
        let ratioForDifficulty = 2 / (1 + exp(difficultyLevel))
        
        let range = initialTimeUntilMarking - minimalTimeUntilMarking
        let currentTimeUntilMarking = minimalTimeUntilMarking + ratioForDifficulty * range
        return Int(currentTimeUntilMarking * 1000)
    }
    
    fileprivate func unmark(row: Int) {
        self.markableCell(in: row)?.marked = false
        if !unmarkedRows.contains(row) {
            unmarkedRows.append(row)
        }
        difficultyLevel += speed
    }
    
    private func endGame() {
        self.stopTimer()
        startButton.isEnabled = true
        self.presentEndGameAlert()
    }
    
    private func presentEndGameAlert() {
        let alert = UIAlertController(title: "You lost!", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func markableCell(in row: Int) -> MarkableTableViewCell? {
        let indexPath = IndexPath(row: row, section: 0)
        return tableView.cellForRow(at: indexPath) as? MarkableTableViewCell
    }
    
    // MARK: -- Optional Time Counter ---
    
    @IBOutlet var ellapsedTimeLabel: UILabel!
    
    private var timer: Timer?
    
    private func startTimer() {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        
        let start = Date()
        ellapsedTimeLabel.text = formatter.string(from: 0)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let ellapsedTime = Date().timeIntervalSince(start)
            self.ellapsedTimeLabel.text = formatter.string(from: ellapsedTime)
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
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
        self.unmark(row: indexPath.row)
    }
}

