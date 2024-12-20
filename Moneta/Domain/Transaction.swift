import Foundation

struct Transaction: Identifiable {
    let id: UUID
    var amount: Int
    var title: String
    var type: TransactionType
    var date: Date

    init(id: UUID = UUID(), amount: Int, title: String, type: TransactionType, date: Date) {
        self.id = id
        self.amount = amount
        self.title = title
        self.type = type
        self.date = date
    }

    enum TransactionType {
        case income
        case expense
    }
}
