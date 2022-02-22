import Foundation

public extension Int32 {
    func commas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: .init(value:self))!
    }
}