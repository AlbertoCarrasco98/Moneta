import Foundation

class ViewModel {

    var transactions: [Transaction] = []
    var databaseManager: TransactionDatabaseManagerProtocol

    var transactionsSortedByDate: [(String, [Transaction])] = []

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
        transactionsSortedByDate = groupTransactionsByDate(transactions: transactions)

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

    // Agrupar transacciones por fecha
    func groupTransactionsByDate(transactions: [Transaction]) -> [(String, [Transaction])] {
        var groupedTransactions = [Date: [Transaction]]()

        // Agrupar las transacciones
        for transaction in transactions {
            let calendar = Calendar.current
            let dateWithoutTime = calendar.startOfDay(for: transaction.date)
            groupedTransactions[dateWithoutTime, default: []].append(transaction)
        }

        // Ordenar las transacciones dentro de cada grupo
        for (key, value) in groupedTransactions {
            groupedTransactions[key] = value.sorted { $0.date > $1.date}
        }

        // Ordenar los grupos por fecha en orden descendente y convertir las fechas a Strings
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "es_ES")

        let sortedGroupedTransactions = groupedTransactions.sorted {
            $0.key > $1.key
        }.map {
            (
                dateFormatter.string(
                    from: $0.key
                ),
                $0.value
            )
        }


//        for transaction in transactions {
//            let dateString = TransactionDateFormatter.configureDateString(for: transaction)
//            if groupedTransactions[dateString] != nil {
//                groupedTransactions[dateString]?.append(transaction)
//            } else {
//                groupedTransactions[dateString] = [transaction]
//            }
//        }
        return sortedGroupedTransactions
    }

    // Agrupar y ordenar transacciones por fecha
//    func groupAndSortTransactions(transactions: [Transaction]) {
//        let groupedTransactions = groupTransactionsByDate(transactions: transactions)
//        self.transactionsSortedByDate = groupedTransactions.sorted { $1.key > $0.key }
//    }










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
