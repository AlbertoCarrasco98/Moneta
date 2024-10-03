import UIKit

class NewTransactionViewController: UIViewController {

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .vertical, space: 12),
            segmentedControlStackView,
            SpacerView(axis: .vertical, space: 70),
            titleTextFieldStackView,
            SpacerView(axis: .vertical, space: 100),
            amountTextFieldStackView,
            UIView(),
            addTransactionButtonStackView,
            SpacerView(axis: .vertical, space: 24)
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        return stackView
    }()

    private lazy var segmentedControlStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .horizontal, space: 60),
            segmentedControl,
            SpacerView(axis: .horizontal, space: 60)
        ])

        return stackView
    }()


    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Gasto", "Ingreso"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderWidth = 2
        segmentedControl.layer.borderColor = UIColor.systemBlue.cgColor
        segmentedControl.addTarget(self, action: #selector(updatePlaceholderTitleTextfield), for: .valueChanged)
        return segmentedControl
    }()

    private lazy var titleTextFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .horizontal, space: 50),
            titleTextField,
            SpacerView(axis: .horizontal, space: 50)
        ])
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        return stackView
    }()

    private lazy var titleTextField: UITextField = {
        let titleTextField = InsetTextField(spacing: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        titleTextField.layer.borderWidth = 2
        titleTextField.layer.borderColor = UIColor.systemBlue.cgColor
        titleTextField.layer.cornerRadius = 10
        titleTextField.layer.masksToBounds = true
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Ingresa un título para el nuevo gasto", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.italicSystemFont(ofSize: 12)
        ])
        return titleTextField
    }()

    private lazy var amountTextFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .horizontal, space: 80),
            amountTextField,
            SpacerView(axis: .horizontal, space: 80)
        ])
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        return stackView
    }()

    private lazy var amountTextField: UITextField = {
        let textField = InsetTextField(spacing: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "Ingresa una cantidad", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.italicSystemFont(ofSize: 12)
        ])
        textField.keyboardType = .decimalPad
        return textField
    }()

    private lazy var addTransactionButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .horizontal, space: 100),
            addTransactionButton,
            SpacerView(axis: .horizontal, space: 100)
        ])
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        return stackView
    }()

    private lazy var addTransactionButton: UIButton = {
        let addButton = UIButton()
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
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        addConstraints()
        hideKeyboardWhenTappedAround()

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

//        viewModel.createTransaction(amount: amount, title: titleText, type: transactionType)
        viewModel.saveTransaction(Transaction(id: UUID(),
                                              amount: amount,
                                              title: titleText,
                                              type: transactionType,
                                              date: Date()))
    }

    @objc func addButtonTapped() {
        addTransaction()
        navigationController?.popViewController(animated: true)
    }

    @objc private func updatePlaceholderTitleTextfield() {
        let indexSegmentedControl = segmentedControl.selectedSegmentIndex

        switch indexSegmentedControl {
            case 0:
                titleTextField.placeholder = "Ingresa un título para el nuevo gasto"
            case 1:
                titleTextField.placeholder = "Ingresa un título para el nuevo ingreso"
            default:
                break
        }
    }

    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
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
}

extension NewTransactionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        amountTextField.becomeFirstResponder()
    }
}

