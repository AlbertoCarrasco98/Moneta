protocol TransactionDatabaseManagerProtocol {
    func saveTransaction(_ transaction: Transaction)
    func getTransactions() -> [Transaction]
    func deleteTransaction(_ transaction: Transaction)
}
