import UIKit

class NewTransactionViewController: UIViewController {

    private let stack = UIStackView()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        segmentedControl.backgroundColor = .yellow
        segmentedControl.layer.borderWidth = 2
        segmentedControl.layer.borderColor = UIColor.systemBlue.cgColor
        return segmentedControl
    }()


    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .brown
        return textField
    }()

    private lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.backgroundColor = .systemBlue

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

    let containerView = UIView()


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
            textField.heightAnchor.constraint(equalToConstant: 35),
//            view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 250),

            // adButton
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            view.trailingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 100),
            view.bottomAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
