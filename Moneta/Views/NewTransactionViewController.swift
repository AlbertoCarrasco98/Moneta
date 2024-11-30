import UIKit

class NewTransactionViewController: UIViewController {
    //    MARK: - Properties

    private let viewModel: ViewModel

    //    MARK: - Initializers

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //    MARK: - UI Elements

    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Gasto", "Ingreso"]
        let segmentedControl = UISegmentedControl(items: items)

        segmentedControl.selectedSegmentIndex = 0

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.widthAnchor.constraint(equalToConstant: 300).isActive = true

        segmentedControl.addTarget(self, action: #selector(updatePlaceholderTitleTextfield), for: .valueChanged)

        return segmentedControl
    }()

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        titleLabel.text = "Título"
        titleLabel.font = .boldSystemFont(ofSize: 22)

        return titleLabel
    }()

    private lazy var titleTextField: UITextField = {
        let titleTextField = InsetTextField(spacing: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        titleTextField.layer.cornerRadius = 10
        titleTextField.layer.masksToBounds = true
        titleTextField.backgroundColor = .systemGray5

        titleTextField.attributedPlaceholder = NSAttributedString(string: "Ingresa un título para el nuevo gasto", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.italicSystemFont(ofSize: 12)
        ])

        return titleTextField
    }()

    lazy var amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        amountLabel.text = "Cantidad"
        amountLabel.font = .boldSystemFont(ofSize: 22)

        return amountLabel
    }()

    private lazy var amountTextField: UITextField = {
        let amountTextField = InsetTextField(spacing: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        amountTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        amountTextField.layer.cornerRadius = 10
        amountTextField.layer.masksToBounds = true
        amountTextField.backgroundColor = .systemGray5

        amountTextField.attributedPlaceholder = NSAttributedString(string: "Ingresa una cantidad", attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.italicSystemFont(ofSize: 12)
        ])
        amountTextField.keyboardType = .decimalPad

        return amountTextField
    }()

    private lazy var addTransactionButton: CustomButton = {
        let addButton = CustomButton()
        addButton.setTitle("Añadir movimiento", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return addButton
    }()

    //    MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    //    MARK: - Setup Methods

    private func setupUI() {
        view.backgroundColor = .systemBackground
        addConstraints()
        hideKeyboardWhenTappedAround()
    }

    private func addConstraints() {
        view.addSubview(segmentedControl)
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(amountLabel)
        view.addSubview(amountTextField)
        view.addSubview(addTransactionButton)

        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addTransactionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            titleLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 48),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            amountLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 48),
            amountTextField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 12),
            view.bottomAnchor.constraint(equalTo: addTransactionButton.bottomAnchor, constant: 64)
        ])
    }

    //    MARK: - Actions

    @objc func addButtonTapped() {
        addTransaction()
    }

    @objc private func updatePlaceholderTitleTextfield() {
        let selectedIndexSegmentedControl = segmentedControl.selectedSegmentIndex
        switch selectedIndexSegmentedControl {
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

    //    MARK: - Helpers

    private func addTransaction() {
        let selectedIndexSegmentedControl = segmentedControl.selectedSegmentIndex
        let transactionType: Transaction.TransactionType = selectedIndexSegmentedControl == 0 ? .expense : .income

        do {
            let title = try getTitleTextFieldValue()
            do {
                let amount = try getAmountTextFieldValue()
                viewModel.saveTransaction(Transaction(id: UUID(),
                                                      amount: amount,
                                                      title: title,
                                                      type: transactionType,
                                                      date: Date()))
                dismiss(animated: true)
            } catch {
                showAlert(message: error.localizedDescription)
            }
        } catch {
            showAlert(message: error.localizedDescription)
        }
    }

    private func getTitleTextFieldValue() throws -> String {
        guard let titleText = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !titleText.isEmpty
        else {
            throw AppError.newTransactionTitleError
        }
        return titleText
    }

    private func getAmountTextFieldValue() throws -> Int {
        guard let amountText = amountTextField.text,
              let amount = Int(amountText), !amountText.isEmpty
        else {
            throw AppError.newTransactionAmountError
        }
        return amount
    }
}

extension NewTransactionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        amountTextField.becomeFirstResponder()
    }
}

