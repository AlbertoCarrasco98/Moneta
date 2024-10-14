class Assembler {

    static func createMainVC() -> MainViewController {
        let databaseManager = TransactionSwiftDataManager()
        let viewModel = ViewModel(databaseManager: databaseManager)
        let vc = MainViewController(viewModel: viewModel)
        return vc
    }

    static func createBalanceVC() -> BalanceViewController {
        let databaseManager = TransactionSwiftDataManager()
        let viewModel = ViewModel(databaseManager: databaseManager)
        let vc = BalanceViewController(viewModel: viewModel)
        return vc
    }
}
