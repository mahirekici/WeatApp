
import Foundation

protocol LocalizableDelegate {
    var rawValue: String { get }
    var table: String? { get }
    var localized: String { get }
}
extension LocalizableDelegate {
    
    var localized: String {
        return Bundle.main.localizedString(forKey: rawValue, value: nil, table: table)
    }
    
    var table: String? {
        return nil
    }
}
