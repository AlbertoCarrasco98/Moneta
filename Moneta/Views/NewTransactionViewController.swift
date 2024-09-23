import UIKit

class NewTransactionViewController: UIViewController {

    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Gasto", "Ingreso"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        //        segmentedControl.backgroundColor = .yellow
        segmentedControl.layer.borderWidth = 2
        segmentedControl.layer.borderColor = UIColor.systemBlue.cgColor
        return segmentedControl
    }()

    private lazy var titleTextField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.layer.borderWidth = 2
        titleTextField.layer.borderColor = UIColor.systemBlue.cgColor
        titleTextField.layer.cornerRadius = 10
        titleTextField.layer.masksToBounds = true
        //        titleTextField.placeholder = "Pon un título a la transacción"
        titleTextField.attributedPlaceholder = NSAttributedString(string: "  Pon aquí un título a la transacción", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.italicSystemFont(ofSize: 12)
        ])
        return titleTextField
    }()

    private lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "  Ingresa aquí una cantidad", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.italicSystemFont(ofSize: 12)
        ])
        return textField
    }()

    private lazy var addTransactionButton: UIButton = {
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

    private let viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addConstraints()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
    }

    private func addTransaction() {
        guard let amountText = amountTextField.text, let amount = Int(amountText) else {
            print("Error: La cantidad no es un número válido")
            return
        }

        guard let titleText = titleTextField.text else {
            print("Error: El título de la transacción no es válido")
            return
        }

        let segmentedControlIndex = segmentedControl.selectedSegmentIndex
        let transactionType: Transaction.TransactionType = segmentedControlIndex == 0 ? .expense : .income

        viewModel.createTransaction(amount: amount, title: titleText, type: transactionType)
    }

    @objc func addButtonTapped() {
        addTransaction()
        navigationController?.popViewController(animated: true)
    }

    private func addConstraints() {
        view.addSubview(segmentedControl)
        view.addSubview(titleTextField)
        view.addSubview(amountTextField)
        view.addSubview(addTransactionButton)
        NSLayoutConstraint.activate([
            // segmentedControl
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            view.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor, constant: 48),

            // titleTextField
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 72),
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            view.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor, constant: 72),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),


            // amountTextField
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 72),
            amountTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            view.trailingAnchor.constraint(equalTo: amountTextField.trailingAnchor, constant: 72),
            amountTextField.heightAnchor.constraint(equalToConstant: 50),

            // adButton
            addTransactionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            view.trailingAnchor.constraint(equalTo: addTransactionButton.trailingAnchor, constant: 100),
            view.bottomAnchor.constraint(equalTo: addTransactionButton.bottomAnchor, constant: 100),
            addTransactionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension NewTransactionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        amountTextField.becomeFirstResponder()
    }
}
