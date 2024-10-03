import Foundation

extension Transaction {
    func mapToSwiftData() -> TransactionSwiftData {
        TransactionSwiftData(id: id,
                             amount: amount,
                             title: title,
                             type: type.mapToSwiftData(),
                             date: date)
    }
}

extension TransactionSwiftData {
    func mapToDomainModel() -> Transaction {
        Transaction(id: id,
                    amount: amount,
                    title: title,
                    type: type.mapToDomainModel(),
                    date: date)
    }
}

extension Transaction.TransactionType {
    func mapToSwiftData() -> TransactionSwiftData.TransactionType {
        switch self {
            case .income:
                return TransactionSwiftData.TransactionType.income
            case .expense:
                return TransactionSwiftData.TransactionType.expense
        }
    }
}

extension TransactionSwiftData.TransactionType {
    func mapToDomainModel() -> Transaction.TransactionType {
        switch self {
            case .income:
                return Transaction.TransactionType.income
            case .expense:
                return Transaction.TransactionType.expense
        }
    }
}

