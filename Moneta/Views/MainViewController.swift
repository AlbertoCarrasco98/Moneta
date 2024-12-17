import UIKit

class MainViewController: UIViewController, MainViewDelegate, NewTransactionDelegate {
    

    //    MARK: - Properties

    private let viewModel: ViewModel

    var groupedTransactions: [(String, [Transaction])] {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "es_ES")
        let sortedTransactions = viewModel.transactions.sorted { $0.date > $1.date }
        let grouped = Dictionary(grouping: sortedTransactions) { transaction in
            dateFormatter.string(from: transaction.date)
        }

        let sortedGrouped = grouped.sorted { (firstGroup, secondGroup) in
            guard
                let firstDate = dateFormatter.date(from: firstGroup.key),
                let secondDate = dateFormatter.date(from: secondGroup.key)
            else {
                return false
            }
            return firstDate > secondDate
        }
        return sortedGrouped
    }

    //    MARK: - Initializers

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //    MARK: - UI Elements

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CustomTransactionwCell.self, forCellReuseIdentifier: "CustomTransactionCell")
        tableView.dataSource = self
        tableView.delegate = self

        tableView.layer.cornerRadius = 10
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
        button.addTarget(self, action: #selector(addTransactionButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var expensesLabel: UILabel = {
        let expensesAmountLabel = UILabel()
        expensesAmountLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        expensesAmountLabel.textColor = .systemRed
        expensesAmountLabel.textAlignment = .center
        return expensesAmountLabel
    }()

    private lazy var incomesLabel: UILabel = {
        let incomesAmountLabel = UILabel()
        incomesAmountLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        incomesAmountLabel.textColor = .systemGreen
        incomesAmountLabel.textAlignment = .center
        return incomesAmountLabel
    }()

    private lazy var placeHolderView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "¡Comienza agregando una nueva transacción!"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    private lazy var labelsView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        view.backgroundColor = .clear

        let expensesTitleLabel = UILabel()
        let incomesTitleLabel = UILabel()

        expensesTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        expensesTitleLabel.text = "Gastos"
        expensesTitleLabel.textAlignment = .center
        incomesTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        incomesTitleLabel.text = "Ingresos"
        incomesTitleLabel.textAlignment = .center

        // ExpensesStackView
        let expensesStackView = UIStackView(arrangedSubviews: [expensesTitleLabel, expensesLabel])
        expensesStackView.axis = .vertical
        expensesStackView.spacing = 8
        expensesStackView.distribution = .fillEqually

        // IncomesStackView
        let incomesStackView = UIStackView(arrangedSubviews: [incomesTitleLabel, incomesLabel])
        incomesStackView.axis = .vertical
        incomesStackView.spacing = 8
        incomesStackView.distribution = .fillEqually

        // MainStackView
        let mainStackView = UIStackView(arrangedSubviews: [expensesStackView, incomesStackView])
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .horizontal
        mainStackView.spacing = 20
        mainStackView.distribution = .fillEqually

        // Agrego todo a la view
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
        ])
        return view
    }()

    //    MARK: - LifeCycle

    override func loadView() {
        super.loadView()
        setupUI()
        let amounts = viewModel.transactions.map { $0.amount }
        print(amounts)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        adjustTableHeaderViewSize()
    }

    //    MARK: - Setup Methods

    private func setupUI() {
        title = "Historial de transacciones"
        view.backgroundColor = .systemBackground
        addConstraints()
        tableView.tableHeaderView = labelsView
        adjustTableHeaderViewSize()
        showPlaceHolderView()
        updateLabels()
    }

    private func addConstraints() {
        view.addSubview(tableView)
        view.addSubview(addTransactionButton)

        NSLayoutConstraint.activate([
            // tableView
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 12),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),

            // addTransactionButton
            addTransactionButton.widthAnchor.constraint(equalToConstant: 50),
            addTransactionButton.heightAnchor.constraint(equalToConstant: 50),
            addTransactionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: addTransactionButton.bottomAnchor, constant: 8)
        ])
    }

    private func showPlaceHolderView() {
        view.addSubview(placeHolderView)
        placeHolderView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        placeHolderView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        placeHolderView.isHidden = !viewModel.transactions.isEmpty

//        if viewModel.transactions.isEmpty == false {
//            placeHolderView.isHidden = true
//        } else {
//            placeHolderView.isHidden = false
//        }
    }

    private func adjustTableHeaderViewSize() {
        guard let headerView = tableView.tableHeaderView else { return }
        headerView.frame.size.width = tableView.bounds.width
        headerView.layoutIfNeeded()
        tableView.tableHeaderView = headerView
    }

    //    MARK: - Actions

    @objc private func addTransactionButtonTapped() {
        let newTransactionVC = NewTransactionViewController(viewModel: self.viewModel)
        newTransactionVC.delegate = self
        navigationController?.present(newTransactionVC, animated: true)
    }

    //MARK: - Helpers

    private func updateLabels() {
        expensesLabel.text = viewModel.calculateTotalExpenses().mapToEur()
        incomesLabel.text = viewModel.calculateTotalIncomes().mapToEur()
    }

    func didCreateNewTransaction() {
        showToast(withMessage: "Transacción creada con éxito",
                  color: .success,
                  position: .bottom)
        showPlaceHolderView()
        tableView.reloadData()
        updateLabels()
    }

    func didDeleteTransaction() {
        showToast(withMessage: "Transacción eliminada",
                  color: .success,
                  position: .bottom)
        showPlaceHolderView()
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        groupedTransactions.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fechas = groupedTransactions[section]
        return fechas.1.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTransactionCell", for: indexPath) as! CustomTransactionwCell

        let grupoDeTransacciones = groupedTransactions[indexPath.section]

        let transaction = grupoDeTransacciones.1[indexPath.row]

        cell.configure(with: transaction)

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let fecha = groupedTransactions[section]
        return fecha.0
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let grupoDeTransacciones = groupedTransactions[indexPath.section]
        let transaction = grupoDeTransacciones.1[indexPath.row]

        let transactionDetailVC = TransactionDetailViewController(viewModel: viewModel,
                                                 transaction: transaction)
        transactionDetailVC.delegate = self
        navigationController?.pushViewController(transactionDetailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension MainViewController {
    func didUpdateTransaction() {
        updateLabels()
    }

    func newTransactionCreated() {
        updateLabels()
        tableView.reloadData()
    }

}

