import PlaygroundSupport
import UIKit

let demo = "LIVEVIEW"

switch demo {
    
case "TIMER":
    
    PlaygroundPage.current.needsIndefiniteExecution = true
    _ = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { timer in
        let endDate = Date()
        print("\(endDate) Timer fired.")
    }
    let startDate = Date()
    print("\(startDate) Timer scheduled.")
    
case "NUMFORMAT":
    
    let d = 3.1415
    
    let str1 = String(format: "%.3f", d)
    print(str1)
    
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.maximumFractionDigits = 2
    numberFormatter.currencyCode = "EUR"
    //numberFormatter.locale = Locale(identifier: "de-DE")
    
    let str2 = numberFormatter.string(from: d as NSNumber)!
    print(str2)
    
case "FILEIO":
    
    let io = FileIO()
    io.write(text: "TEXT")
    io.read()
    
    let data = "DATA".data(using: .utf8)!
    io.write(data: data)
    io.read()
    
case "LIVEVIEW":
    
    let vc = DrawingViewController()
    PlaygroundPage.current.liveView = vc
    
default:
    break
    
}
