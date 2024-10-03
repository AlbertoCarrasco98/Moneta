protocol TransactionDatabaseManagerProtocol {
    func saveTransaction(_ transaction: Transaction)
    func getTransaction() -> [Transaction]
    func deleteTransaction(_ transaction: Transaction)
}
