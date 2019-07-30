//
//  MyTableViewController.swift
//  Exercise5
//
//  Created by Ernesto Elsäßer on 10.06.18.
//  Copyright © 2018 Ernesto Elsaesser. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {

    // tuneable parameters
    let rowCount = 7
    let difficultyFactor: Double = 0.95
    var markingInterval: TimeInterval = 1.5
    
    var unmarkedRows: Set<Int> = Set()
    var startDate: Date?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func startTapped(_ sender: Any) {
        navigationItem.setRightBarButton(nil, animated: false)
        self.startGame()
    }
    
    func startGame() {
        
        for row in 0..<rowCount {
            unmarkedRows.insert(row)
        }
        
        startDate = Date()
        self.updateTimer()
    }
    
    func updateTimer() {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: markingInterval, repeats: true) { _ in
            self.markRandomRowOrLose()
        }
    }
    
    func markRandomRowOrLose() {
        if let randomRow = unmarkedRows.randomElement() {
            let indexPath = IndexPath(row: randomRow, section: 0)
            self.mark(indexPath: indexPath)
        } else {
            self.lose()
        }
    }
    
    func mark(indexPath: IndexPath) {
        guard unmarkedRows.contains(indexPath.row) else {
            return
        }
        let cell = tableView.cellForRow(at: indexPath)
        let myCell = cell as? MyTableViewCell
        myCell?.mark()
        unmarkedRows.remove(indexPath.row)
    }
    
    func unmark(indexPath: IndexPath) {
        guard !unmarkedRows.contains(indexPath.row) else {
            return
        }
        let cell = tableView.cellForRow(at: indexPath)
        let myCell = cell as? MyTableViewCell
        myCell?.unmark()
        unmarkedRows.insert(indexPath.row)
    }
    
    func lose() {
        timer?.invalidate()
        
        var message: String?
        if let start = startDate {
            let gameTime = Date().timeIntervalSince(start)
            message = "You played for \(gameTime) seconds!"
        }
        
        let alert = UIAlertController(title: "You lost!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Table View
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.unmark(indexPath: indexPath)
        self.markingInterval *= difficultyFactor
        self.updateTimer()
    }
}

