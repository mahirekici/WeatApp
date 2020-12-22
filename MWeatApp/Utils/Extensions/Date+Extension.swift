
import Foundation

extension Date {
    enum BrazilianDate: String {
        case short = "dd/mm"
        case long = "dd/mm/yyyy"
    }
    func string(format: BrazilianDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.dateFormat = format.rawValue
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
