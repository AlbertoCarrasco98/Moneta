import UIKit

class MainViewController: UIViewController {

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .vertical, space: 50),
            tableView,
//            SpacerView(axis: .vertical, space: 50),
            buttonStackView,
            SpacerView(axis: .vertical, space: 8),
            labelStackView,
            SpacerView(axis: .vertical, space: 10)
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        return stackView
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .horizontal, space: 140),
            addTransactionButton,
            SpacerView(axis: .horizontal, space: 140)
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .horizontal, space: 100),
            addTransactionLabel,
            SpacerView(axis: .horizontal, space: 110)
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(CustomTransactionwCell.self, forCellReuseIdentifier: "CustomTransactionCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private lazy var addTransactionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 25
        button.backgroundColor = UIColor(red: 0.3, green: 0.55, blue: 1, alpha: 0.5)
        button.clipsToBounds = true

        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true

        button.addTarget(self, action: #selector(addTransactionButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var addTransactionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Añadir transacción"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray4
        return label
    }()

    private let viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        setupUI()
        print(viewModel.transactionsSortedByDate)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    private func setupUI() {
        title = "Historial de transacciones"
        view.backgroundColor = .systemBackground
        addConstraints()
    }

    private func addConstraints() {
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor)
        ])
    }

    @objc private func addTransactionButtonTapped() {
        let vc = NewTransactionViewController(viewModel: self.viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.transactionsSortedByDate.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.transactions.count
        viewModel.transactionsSortedByDate[section].1.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTransactionCell", for: indexPath) as! CustomTransactionwCell

//        let transaction = viewModel.transactions[indexPath.row]
        let transaction = viewModel.transactionsSortedByDate[indexPath.section].1[indexPath.row]

        cell.configure(with: transaction)

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.transactionsSortedByDate[section].0
    }
}

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = TransactionDetailViewController(viewModel: viewModel,
                                                 transaction: viewModel.transactions[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
