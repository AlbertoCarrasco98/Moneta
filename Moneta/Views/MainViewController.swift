import UIKit

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


