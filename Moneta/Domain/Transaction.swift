import Foundation

struct Transaction: Identifiable {
    let id: UUID
    let amount: Int
    let title: String
    let type: TransactionType
    let date: Date

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
