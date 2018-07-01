import Foundation

public class MyFormatter {
    
    let numberFormatter = NumberFormatter()
    
    public init() {}
    
    public func format1(number: Double) -> String {
        
        return String(format: "%.3f", number)
    }
    
    public func format2(number: Double) -> String {
        
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.currencyCode = "EUR"
        //numberFormatter.locale = Locale(identifier: "de-DE")
        return numberFormatter.string(from: number as NSNumber) ?? ""
    }
}
