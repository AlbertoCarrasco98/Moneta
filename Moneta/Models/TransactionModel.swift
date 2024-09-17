struct Transaction {
    let amount: Int
    let type: TransactionType

    enum TransactionType {
        case income
        case expense
    }
}
