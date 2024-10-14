import Foundation

class ViewModel {

    var transactions: [Transaction] = []
    var databaseManager: TransactionDatabaseManagerProtocol

    init(databaseManager: TransactionDatabaseManagerProtocol) {
        self.databaseManager = databaseManager
        loadTransactions()
    }

    func saveTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        databaseManager.saveTransaction(transaction)
    }

    func loadTransactions() {
        transactions = databaseManager.getTransactions()
    }

    func getTransactionBy(id: UUID) -> TransactionSwiftData? {
        databaseManager.getTransactionBy(id: id)
    }

    func deleteTransaction(_ transaction: Transaction) {
        databaseManager.deleteTransaction(transaction)
    }

    func createTransaction(_ transaction: Transaction) {
        let newTransaction = Transaction(amount: transaction.amount,
                                         title: transaction.title,
                                         type: transaction.type,
                                         date: Date())
        saveTransaction(newTransaction)
    }

    func calculateTotalExpenses() -> Double {
        let expenses = transactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        return Double(expenses)
    }

    func calculateTotalIncomes() -> Double {
        let incomes = transactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        return Double(incomes)
    }

    func calculateTotalBalance() -> Double {
        calculateTotalIncomes() - calculateTotalExpenses()
    }
}
