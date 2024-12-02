protocol EditTransactionViewControllerDelegate: AnyObject {
    func didUpdateTransaction(_ transaction: Transaction)
}

protocol NewTransactionViewControllerDelegate: AnyObject {
    func didCreateNewTransaction()
}

protocol DeleteTransactionViewControllerDelegate: AnyObject {
    func didDeleteTransaction()
}
