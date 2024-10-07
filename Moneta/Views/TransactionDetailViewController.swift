import UIKit

class TransactionDetailViewController: UIViewController {

    let transaction: Transaction

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

    private func moneyLabelIcon() -> String {
        switch transaction.type {
            case .income:
                return "💰"
            case .expense:
                return "💶"
        }
    }

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
        label.text = String(transaction.amount)
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = colorAmountLabel()
        label.textAlignment = .center
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true

        return label
    }()

    private func colorAmountLabel() -> UIColor {
        switch transaction.type {
            case .income:
                return UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
            case .expense:
                return UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }

    init(transaction: Transaction) {
        self.transaction = transaction

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
        addCosntraints()
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
            view.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 24),
        ])
    }

    private func dateFormatter(for transaction: Transaction) -> String {
        let date = transaction.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "es_ES")

        let dateString = dateFormatter.string(from: date)
        return dateString.prefix(1).capitalized + dateString.dropFirst()
    }
}
