import UIKit

class NewTransactionViewController: UIViewController {

    var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Gasto", "Ingreso"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        segmentedControl.backgroundColor = .yellow
        segmentedControl.layer.borderWidth = 2
        segmentedControl.layer.borderColor = UIColor.systemBlue.cgColor
        return segmentedControl
    }()


    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.placeholder = "  Ingresa aquí una cantidad"
        return textField
    }()

    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.layer.borderWidth = 2
        addButton.layer.borderColor = UIColor.systemBlue.cgColor
        addButton.layer.cornerRadius = 10
        addButton.setTitle("Añadir movimiento", for: .normal)
        addButton.setTitleColor(.systemGray, for: .normal)
        addButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
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

    private func addTransaction() {
        guard let amountText = textField.text, let amount = Int(amountText) else {
            print("Error: La cantidad no es un número válido")
            return
        }

        let segmentedControlIndex = segmentedControl.selectedSegmentIndex
        let transactionType: Transaction.TransactionType = segmentedControlIndex == 0 ? .expense : .income

        viewModel.createTransaction(amount: amount, type: transactionType)
    }

    @objc func addButtonTapped() {
        addTransaction()
        navigationController?.popViewController(animated: true)
    }

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
            textField.heightAnchor.constraint(equalToConstant: 50),
//            view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 250),

            // adButton
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            view.trailingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 100),
            view.bottomAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
