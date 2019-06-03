import PlaygroundSupport
import UIKit

let manager = FileManager.default
let fileName = "sample.txt"

do {
    
    let documentDirectoryUrl = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let fileUrl = documentDirectoryUrl.appendingPathComponent(fileName)

    // write text
    let text = "TEXT"
    try text.write(to: fileUrl, atomically: false, encoding: .utf8)
    
    // write data
    let data = "DATA".data(using: .utf8)!
    try data.write(to: fileUrl)
    
    // read
    let string = try String(contentsOf: fileUrl, encoding: .utf8)
    print(string)

} catch {
    print(error)
}
