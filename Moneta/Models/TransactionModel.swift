struct Transaction {
    let amount: Int
    let title: String
    let type: TransactionType

    enum TransactionType {
        case income
        case expense
    }
}
