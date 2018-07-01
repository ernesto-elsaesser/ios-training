import Foundation

public class FileIO {
    
    let manager = FileManager.default
    let fileName = "sample.txt"
    
    public init() {}
    
    public func write(text: String) {
        
        do {
            
            let documentDirectoryUrl = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileUrl = documentDirectoryUrl.appendingPathComponent(fileName)
            try text.write(to: fileUrl, atomically: false, encoding: .utf8)
            
        } catch {
            
            print(error)
        }
    }
    
    public func write(data: Data) {
        
        do {
            
            let documentDirectoryUrl = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileUrl = documentDirectoryUrl.appendingPathComponent(fileName)
            try data.write(to: fileUrl)
            
        } catch {
            
            print(error)
        }
    }
    
    public func read() -> String {
        
        do {
            
            let documentDirectoryUrl = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileUrl = documentDirectoryUrl.appendingPathComponent(fileName)
            
            return try String(contentsOf: fileUrl, encoding: .utf8)
            
        } catch {
            
            print(error)
            return ""
        }
    }
}
