import Foundation

class ViewModel: TransactionDatabaseManagerProtocol {

    var transactions: [Transaction] = []

    var databaseManager = TransactionSwiftDataManager()

    func saveTransaction(_ transaction: Transaction) {
        databaseManager.saveTransaction(transaction)
        
    }

    func getTransaction() -> [Transaction] {
        databaseManager.getTransaction()
    }

    func deleteTransaction(_ transaction: Transaction) {
        databaseManager.deleteTransaction(transaction)
    }


    func createTransaction(amount: Int, title: String, type: Transaction.TransactionType) {
        let transaction = Transaction(amount: amount,
                                      title: title,
                                      type: type,
                                      date: Date())
        transactions.append(transaction)
        print("El valor del array es:\(transactions) ")
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
