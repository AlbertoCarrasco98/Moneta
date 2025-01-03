import UIKit

protocol TransactionDetailViewDelegate: AnyObject {
    func didUpdateTransaction()
    func didDeletedTransaction()
}

class TransactionDetailViewController: UIViewController, EditTransactionViewDelegate {

    //    MARK: - Properties

    var transaction: Transaction
    let viewModel: ViewModel
    weak var delegate: TransactionDetailViewDelegate?

    //    MARK: - Initializers

    init(viewModel: ViewModel, transaction: Transaction) {
        self.transaction = transaction
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //    MARK: - UI Elements

    lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.text = moneyLabelIcon()
        label.font = .boldSystemFont(ofSize: 50)
        label.textAlignment = .center
        return label
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.text = transaction.title
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 16).isActive = true
        label.widthAnchor.constraint(equalToConstant: 250).isActive = true
        label.text = dateFormatter(for: transaction)
        label.textAlignment = .center
        label.font = .italicSystemFont(ofSize: 12)
        return label
    }()

    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        label.text = transaction.amount.mapToEur()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = UIColor.colorAmountLabel(transaction: transaction)
        label.textAlignment = .center
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()

    //    MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.didUpdateTransaction()
    }

    //    MARK: - Setup Methods

    private func setupUI() {
        addCosntraints()
        configureNavigationBar()
        title = "Detalle de transacción"
        view.backgroundColor = .systemBackground
    }

    private func addCosntraints() {
        view.addSubview(moneyLabel)
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(amountLabel)
        view.addSubview(UIView())

        NSLayoutConstraint.activate([

            moneyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            moneyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 24),
            titleLabel.topAnchor.constraint(equalTo: moneyLabel.bottomAnchor, constant: 20),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),

            amountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            amountLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24),
            view.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 24)
        ])
    }

    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = createOptionsMenu()
    }

    private func createOptionsMenu() -> UIBarButtonItem {
        let optionsMenu = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),
                                          style: .plain,
                                          target: self,
                                          action: nil)

        let deleteButtonAction = UIAction(title: "Eliminar",
                                          image: UIImage(systemName: "trash")?.withTintColor(.red, renderingMode: .alwaysOriginal)) { action in
            self.presentDeleteTransactionAlert()
        }
        let editButtonAction = UIAction(title: "Modificar",
                                        image: UIImage(systemName: "gear")) { action in
            self.editButtonTapped()
        }
        let menu = UIMenu(children: [editButtonAction, deleteButtonAction])
        optionsMenu.menu = menu
        return optionsMenu
    }

    private func presentDeleteTransactionAlert() {
        let alertController = UIAlertController(title: "Eliminar transacción",
                                                message: "¿Estás seguro de que quieres eliminar la transacción?",
                                                preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Eliminar",
                                     style: .destructive) { [weak self] _ in
            guard let self = self else { return }

            self.viewModel.deleteTransaction(self.transaction) { [weak self] result in
                guard let self = self else { return }

                DispatchQueue.main.async {
                    switch result {
                        case .success:
                            self.navigationController?.popViewController(animated: true)
                        case .failure(let error):
                            self.showToast(withMessage: error.localizedDescription,
                                           color: .failure,
                                           position: .center)
                    }
                }
            }
            delegate?.didDeletedTransaction()
        }

        let cancelAction = UIAlertAction(title: "Cancelar",
                                         style: .cancel) { UIAlertAction in
            NSLog("Cancel Pressed")
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController,
                     animated: true,
                     completion: nil)
    }

    //MARK: - Helpers

    private func editButtonTapped() {
        let editTransactionVC = EditTransactionViewController(viewModel: viewModel,
                                                              transaction: transaction)
        editTransactionVC.delegate = self
        self.navigationController?.present(editTransactionVC, animated: true)
    }

    private func moneyLabelIcon() -> String {
        switch transaction.type {
            case .income:
                return "💰"
            case .expense:
                return "💶"
        }
    }

    private func dateFormatter(for transaction: Transaction) -> String {
        let date = transaction.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "es_ES")
        let dateString = dateFormatter.string(from: date)
        return dateString.prefix(1).capitalized + dateString.dropFirst()
    }
}

// MARK: - Protocols methods

extension TransactionDetailViewController {
    func didUpdateTransaction(_ transaction: Transaction) {
        self.transaction = transaction
        titleLabel.text = transaction.title
        amountLabel.text = transaction.amount.mapToEur()
        amountLabel.textColor = UIColor.colorAmountLabel(transaction: transaction)
        dateLabel.text = dateFormatter(for: transaction)
    }
}
