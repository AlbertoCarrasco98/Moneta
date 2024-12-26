import UIKit

protocol EditTransactionViewDelegate: AnyObject {
    func didUpdateTransaction(_ transaction: Transaction)
}

class EditTransactionViewController: UIViewController {
    
    //    MARK: - Properties
    private let viewModel: ViewModel
    var transaction: Transaction
    weak var delegate: EditTransactionViewDelegate?
    
    //    MARK: - Initializers
    
    init(viewModel: ViewModel, transaction: Transaction) {
        self.viewModel = viewModel
        self.transaction = transaction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - UI Elements
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Gasto", "Ingreso"]
        let segmentedControl = UISegmentedControl(items: items)
        
        segmentedControl.selectedSegmentIndex = indexForTransactionType()
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.widthAnchor.constraint(equalToConstant: 300).isActive = true
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
    
    lazy var titleTextField: UITextField = {
        let titleTextField = InsetTextField(spacing: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        titleTextField.layer.cornerRadius = 10
        titleTextField.layer.masksToBounds = true
        titleTextField.backgroundColor = .systemGray5
        
        titleTextField.text = transaction.title
        
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
    
    lazy var amountTextField: UITextField = {
        let amountTextField = InsetTextField(spacing: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        amountTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        amountTextField.layer.cornerRadius = 10
        amountTextField.layer.masksToBounds = true
        amountTextField.backgroundColor = .systemGray5
        amountTextField.attributedPlaceholder = NSAttributedString(string: transaction.amount.mapToEur(),
                                                                   attributes: [
                                                                    .foregroundColor: UIColor.lightGray,
                                                                    .font: UIFont.italicSystemFont(ofSize: 14)
                                                                   ])
        amountTextField.keyboardType = .decimalPad
        
        return amountTextField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.date = transaction.date
        datePicker.locale = Locale(identifier: "es_ES")
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        return datePicker
    }()
    
    lazy var saveButton: CustomButton = {
        let saveButton = CustomButton()
        saveButton.setTitle("Guardar", for: .normal)
        saveButton.addTarget(self,
                             action: #selector(saveButtonTapped),
                             for: .touchUpInside)
        return saveButton
    }()
    
    //    MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //    MARK: - Setup Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        self.title = "Editar transacción"
        addConstraint()
        hideKeyboardWhenTappedAround()
        setupErrorsHandling()
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func setupErrorsHandling() {
        viewModel.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showToast(withMessage: error.localizedDescription,
                                color: .failure,
                                position: .center)
            }
        }
    }
    
    private func addConstraint() {
        view.addSubview(segmentedControl)
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(amountLabel)
        view.addSubview(amountTextField)
        view.addSubview(datePicker)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            titleLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 48),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            amountLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 48),
            amountTextField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 12),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            datePicker.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 50),
            view.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 64)
        ])
    }
    
    //    MARK: - Actions
    
    @objc private func datePickerChanged(_ sender: UIDatePicker) {
        datePicker.date = sender.date
    }
    
    @objc func saveButtonTapped() {
        updateTransaction()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //    MARK: - Helpers
    
    private func updateTransaction() {
        transaction.type = getSelectedIndexSegmentedControl()
        transaction.date = datePicker.date
        do {
            try transaction.title = getTitleTextFieldValue()
            do {
                try transaction.amount = getAmountTextFieldValue()
                viewModel.updateTransaction(self.transaction)
                viewModel.loadTransactions()
                delegate?.didUpdateTransaction(transaction)
                dismiss(animated: true)
            } catch {
                showToast(withMessage: AppError.editAmountTransactionError.localizedDescription,
                          color: .failure,
                          position: .center)
            }
        } catch {
            showToast(withMessage: AppError.editTitleTransactionError.localizedDescription,
                      color: .failure,
                      position: .center)
        }
    }
    
    private func getTitleTextFieldValue() throws -> String {
        guard let titleText = titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !titleText.isEmpty
        else {
            throw AppError.editTitleTransactionError
        }
        return titleText
    }
    
    private func getAmountTextFieldValue() throws -> Int {
        if amountTextField.text?.isEmpty == true {
            return transaction.amount
        } else {
            guard let amountText = amountTextField.text, !amountText.isEmpty
            else {
                throw AppError.editAmountTransactionError
            }
            let amount = amountText.mapToCents()
            guard amount > 0
            else {
                throw AppError.editAmountTransactionError
            }
            return amount
        }
    }
    
    private func indexForTransactionType() -> Int {
        switch transaction.type {
            case .income:
                return 1
            case .expense:
                return 0
        }
    }
    
    private func getSelectedIndexSegmentedControl() -> Transaction.TransactionType {
        let selectedIndexSegmentedControl = segmentedControl.selectedSegmentIndex
        let transactionType: Transaction.TransactionType = selectedIndexSegmentedControl == 0 ? .expense : .income
        return transactionType
    }
}
