import UIKit

class MainViewController: UIViewController {

    let viewModel = ViewModel()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = UIColor.systemBlue.cgColor
        tableView.layer.cornerRadius = 10
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

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
        button.addTarget(self, action: #selector(addTransactionButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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

    @objc private func addTransactionButtonTapped() {
        let vc = NewTransactionViewController(viewModel: self.viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let transaction = viewModel.transactions[indexPath.row]

        let typeText = transaction.type == .income ? "+ Ingreso" : "- Gasto"

        cell.textLabel?.text = "\(typeText): \(transaction.amount)€"

        return cell
    }
}

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


