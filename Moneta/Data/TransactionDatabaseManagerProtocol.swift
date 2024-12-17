import Foundation

protocol TransactionDatabaseManagerProtocol {
    func saveTransaction(_ transaction: Transaction) throws
    func getTransactions() throws -> [Transaction]
    func getTransactionBy(id: UUID) throws -> TransactionSwiftData?
    func updateTransaction(_ transaction: Transaction) throws
    func deleteTransaction(_ transaction: Transaction) throws
}
