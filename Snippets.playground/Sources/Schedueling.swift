import Foundation

public class MyTimer {
    
    var timer : Timer?
    
    public init() {}
    
    public func start() {
        
        self.cancel()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
                                     selector: #selector(self.fire), userInfo: nil, repeats: true)
    }
    
    public func cancel() {
        
        timer?.invalidate()
        timer = nil
    }
    
    @objc func fire() {
        
        print("FIRE")
    }
}
