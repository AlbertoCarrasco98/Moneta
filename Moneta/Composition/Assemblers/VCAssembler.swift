class Assembler {
    static let databaseManager = TransactionSwiftDataManager()
    
    static func createMainVC() -> MainViewController {
        let viewModel = ViewModel(databaseManager: databaseManager)
        let vc = MainViewController(viewModel: viewModel)
        return vc
    }
}
