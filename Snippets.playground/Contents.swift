import PlaygroundSupport
import UIKit

// timer

/*
PlaygroundPage.current.needsIndefiniteExecution = true
let timer = MyTimer()
timer.start()
 */


// number formatting

/*
let d = 3.1415
let formatter = MyFormatter()
formatter.format1(number: d)
formatter.format2(number: d)
 */

// file IO

/*
let io = FileIO()
io.write(text: "TEXT")
io.read()

let data = "DATA".data(using: .utf8)!
io.write(data: data)
io.read()
 */

// network call

/*
let loader = DataLoader()
loader.loadZen()
 */

// view controller

let vc = DrawingViewController()
PlaygroundPage.current.liveView = vc
