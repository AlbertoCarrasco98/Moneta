import Foundation

class ViewModel {

    var transactions: [Transaction] = []
    var databaseManager: TransactionDatabaseManagerProtocol

    init(databaseManager: TransactionDatabaseManagerProtocol) {
        self.databaseManager = databaseManager
        loadTransactions()
    }

// MARK: - METHODS

    // Actualizar transacción
    func updateTransaction(_ transaction: Transaction) {
        databaseManager.updateTransaction(transaction)
    }

    // Guardar transacción
    func saveTransaction(_ transaction: Transaction) {
        let newTransaction = Transaction(amount: transaction.amount,
                                         title: transaction.title,
                                         type: transaction.type,
                                         date: Date())
        databaseManager.saveTransaction(newTransaction)
        transactions.append(newTransaction)
        loadTransactions()
    }

    // Obtener transacciones
    func loadTransactions() {
        transactions = databaseManager.getTransactions()
        transactions.sort { $0.date > $1.date }
    }

    // Obtener una transacción
    func getTransactionBy(id: UUID) -> TransactionSwiftData? {
        databaseManager.getTransactionBy(id: id)
    }

    // Borrar transacción
    func deleteTransaction(_ transaction: Transaction) {
        databaseManager.deleteTransaction(transaction)
        loadTransactions()
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
