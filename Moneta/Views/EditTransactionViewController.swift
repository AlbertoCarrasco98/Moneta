import UIKit

class EditTransactionViewController: UIViewController {
    var viewmodel: ViewModel
    var transaction: Transaction

    weak var delegate: EditTransactionViewControllerDelegate?

    init(viewModel: ViewModel, transaction: Transaction) {
        self.viewmodel = viewModel
        self.transaction = transaction
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Gasto", "Ingreso"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0

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
        titleTextField.attributedPlaceholder = NSAttributedString(string: transaction.title,
                                                                  attributes: [
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

    lazy var amountTextField: UITextField = {
        let amountTextField = InsetTextField(spacing: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        amountTextField.layer.cornerRadius = 10
        amountTextField.layer.masksToBounds = true
        amountTextField.backgroundColor = .systemGray5
        amountTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        amountTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        amountTextField.attributedPlaceholder = NSAttributedString(string: String(transaction.amount),
                                                                   attributes: [
                                                                     .foregroundColor: UIColor.lightGray,
                                                                     .font: UIFont.italicSystemFont(ofSize: 12)
                                                                   ])
        return amountTextField
    }()

    lazy var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        saveButton.layer.cornerRadius = 10
        saveButton.setTitle("Guardar", for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
//        saveButton.setTitleColor(.systemGray, for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.addTarget(self,
                             action: #selector(saveButtonTapped),
                             for: .touchUpInside)

        return saveButton
    }()

    @objc func saveButtonTapped() {
        guard let titleText = titleTextField.text else {
            print("Error: El título de la transacción no es válido")
            return
        }
        transaction.title = titleText

        delegate?.didUpdateTransaction(transaction)

        viewmodel.updateTransaction(self.transaction)
        viewmodel.loadTransactions()
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        self.title = "Editar transacción"
        addConstraint()
    }

    private func addConstraint(){
        view.addSubview(segmentedControl)
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(amountLabel)
        view.addSubview(amountTextField)
        view.addSubview(UIView())
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

//            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
//            view.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor, constant: 48),

            amountLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 48),

//            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            amountTextField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 12),
//            view.trailingAnchor.constraint(equalTo: amountTextField.trailingAnchor, constant: 48),
            view.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 64)
        ])
    }

}
