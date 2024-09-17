import UIKit

struct Transaction {
    let amount: Int
    let type: TransactionType

    enum TransactionType {
        case income
        case expense
    }
}

class DatabaseManager {

    func saveTransaction(_ transaction: Transaction) {

    }

    func getTransaction() {

    }

    func deleteTransaction() {

    }
}

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

class MainViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemPink
        return tableView
    }()

    private lazy var addTransactionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 25
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "MONETA"
        addConstraints()
    }

    private func addConstraints() {
        view.addSubview(tableView)
        view.addSubview(addTransactionButton)

        NSLayoutConstraint.activate([
            // tableView
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 24),
            tableView.heightAnchor.constraint(equalToConstant: 300),

            // button
            addTransactionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            view.trailingAnchor.constraint(equalTo: addTransactionButton.trailingAnchor, constant: 150),
            view.bottomAnchor.constraint(equalTo: addTransactionButton.bottomAnchor, constant: 100),
            addTransactionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

class NewTransactionViewController: UIViewController {

    private let stack = UIStackView()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        segmentedControl.backgroundColor = .yellow
        segmentedControl.layer.borderWidth = 2
        segmentedControl.layer.borderColor = UIColor.systemBlue.cgColor
        return segmentedControl
    }()


    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .brown
        return textField
    }()

    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.backgroundColor = .systemBlue

        return addButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addConstraints()
    }

    private func setupUI() {
        title = "Add new transaction"
        view.backgroundColor = .systemBackground
    }

    let containerView = UIView()


    private func addConstraints() {
        view.addSubview(segmentedControl)
        view.addSubview(textField)
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            // segmentedControl
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            view.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor, constant: 48),

            // textField
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 72),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            view.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 72),
            textField.heightAnchor.constraint(equalToConstant: 35),
//            view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 250),

            // adButton
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            view.trailingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 100),
            view.bottomAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
