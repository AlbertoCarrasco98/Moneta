import Foundation

class ViewModel {
    var transactions: [Transaction] = []
    var databaseManager: TransactionDatabaseManagerProtocol
    var onError: ((Error) -> Void)?

    init(databaseManager: TransactionDatabaseManagerProtocol) {
        self.databaseManager = databaseManager
        loadTransactions()
    }

    // MARK: - METHODS

    // Actualizar transacción
    func updateTransaction(_ transaction: Transaction) {
        do {
            try databaseManager.updateTransaction(transaction)
        } catch {
            onError?(AppError.internalError)
        }
    }

    // Guardar transacción
    func saveTransaction(_ transaction: Transaction) {
        let newTransaction = Transaction(amount: transaction.amount,
                                         title: transaction.title,
                                         type: transaction.type,
                                         date: transaction.date)
        do {
            try databaseManager.saveTransaction(newTransaction)
            transactions.append(newTransaction)
            loadTransactions()
        } catch {
            onError?(AppError.internalError)
        }
    }

    // Obtener transacciones
    func loadTransactions() {
        do {
            transactions = try databaseManager.getTransactions()
            transactions.sort { $0.date > $1.date }
        } catch {
            onError?(AppError.internalError)
        }
    }

    // Obtener una transacción
    func getTransactionBy(id: UUID) -> TransactionSwiftData? {
        do {
            let transaction = try databaseManager.getTransactionBy(id: id)
            return transaction
        } catch {
            return nil
        }
    }

    // Borrar transacción
    func deleteTransaction(_ transaction: Transaction, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try databaseManager.deleteTransaction(transaction)
            loadTransactions()
            completion(.success(()))
        } catch {
            //            onError?(AppError.internalError)
            completion(.failure(error))
        }
    }

    func calculateTotalExpenses() -> Int {
        let expenses = transactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        return expenses
    }

    func calculateTotalIncomes() -> Int {
        let incomes = transactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        return incomes
    }

    func calculateTotalBalance() -> Int {
        calculateTotalIncomes() - calculateTotalExpenses()
    }
}
