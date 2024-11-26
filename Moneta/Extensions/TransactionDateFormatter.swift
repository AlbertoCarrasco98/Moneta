import UIKit

class TransactionDateFormatter {

    static func configureDateString(for transaction: Transaction) -> String {
        let date = transaction.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "es_ES")

        let dateString = dateFormatter.string(from: date)
        return dateString
    }

    static func map(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "es_ES")

        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

