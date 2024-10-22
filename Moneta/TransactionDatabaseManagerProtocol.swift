import Foundation

protocol TransactionDatabaseManagerProtocol {
    func saveTransaction(_ transaction: Transaction)
    func getTransactions() -> [Transaction]
    func getTransactionBy(id: UUID) -> TransactionSwiftData?
    func deleteTransaction(_ transaction: Transaction)
    func updateTransaction(_ transaction: Transaction)
}
