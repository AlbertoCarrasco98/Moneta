import UIKit

class MainViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(CustomTransactionwCell.self, forCellReuseIdentifier: "CustomTransactionCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private lazy var buttonAndLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(addTransactionButton)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
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

    private let viewModel: ViewModel

    // Propiedad computada, toma el valor cuando se la llama, por lo que las transaccioenes siempre estaran actualizadas ya que accede al valor de viewmode.transactions en cada momento que se le llame
//    var groupedTransactions: [(String, [Transaction])] {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "d MMM yyyy"
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//
//        // grouped es un diccionario donde la clave es un String (fecha de la transaccion pasada a String, linea 53) y el valor es un [Transaction] el cual contiene las transacciones que hay en dicha fecha
//        let grouped = Dictionary(grouping: viewModel.transactions) { transaction in
//            dateFormatter.string(from: transaction.date)
//        }
//
//        // sortedGrouped es un array de tuplas donde el valor 0 es un String (fecha de la transaccion) y el valor 1 es un [Transaction] el cual contiene las transacciones que hay en dicha fecha
//        let sortedGrouped = grouped
//            .map { (key, value) in
//                (key, value)
//            }
//            .sorted { $0.0 > $1.0 }
//        return sortedGrouped
//    }

    var groupedTransactions: [(String, [Transaction])] {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let fechas = viewModel.transactions.map { $0.date }
        for fecha in fechas {
            print(fecha)
        }
//        print(viewModel.transactions.map { "\($0.date)" }.joined(separator: "\n"))

//        for transaction in viewModel.transactions {
//            print(transaction.date)
//        }
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

    @objc private func addTransactionButtonTapped() {
        let vc = NewTransactionViewController(viewModel: self.viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }

    private func addConstraints() {
        view.addSubview(tableView)
        view.addSubview(buttonAndLabelStackView)

        // tableView
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 8),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),

            // buttonAndLabelStackView
            buttonAndLabelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: buttonAndLabelStackView.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: buttonAndLabelStackView.bottomAnchor, constant: 8)
        ])
    }
}

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

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let grupoDeTransacciones = groupedTransactions[indexPath.section]
        let transaction = grupoDeTransacciones.1[indexPath.row]

        let vc = TransactionDetailViewController(viewModel: viewModel,
                                                 transaction: transaction)
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

