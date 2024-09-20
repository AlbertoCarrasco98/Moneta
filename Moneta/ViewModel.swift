import Foundation
import Combine

class ViewModel {

    var transactions: [Transaction] = []

    let databaseManager = DatabaseManager()

//    var newTransactionSignal = PassthroughSubject<Transaction, Never>()

    func createTransaction(amount: Int, title: String, type: Transaction.TransactionType) {
        let transaction = Transaction(amount: amount,
                                      title: title,
                                      type: type)
        transactions.append(transaction)
        print("El valor del array es:\(transactions) ")
//        newTransactionSignal.send(transaction)
    }

    func save(_ transaction: Transaction) {
//        Save in local database
    }

    func getTransaction() -> Transaction {
        return Transaction(amount: 0, title: "", type: .expense)
    }

    func deleteTransaction(_ transaction: Transaction) {

    }
}
