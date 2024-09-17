class ViewModel {
    let databaseManager = DatabaseManager()

    func save(_ transaction: Transaction) {
//        Save in local database
    }

    func getTransaction() -> Transaction {
//        Devuelve los movements
        Transaction(amount: 1,
                 type: .expense)
    }

    func deleteTransaction(_ transaction: Transaction) {

    }
}
