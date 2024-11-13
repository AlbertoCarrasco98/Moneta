import UIKit

class CustomTransactionwCell: UITableViewCell {

    private let containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 10
        return container
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    let typeLabel: UILabel = {
        let image = UILabel()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        containerView.backgroundColor = highlighted ? UIColor.lightGray.withAlphaComponent(0.3) : .systemGray6
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(typeLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(amountLabel)

        selectionStyle = .none

        NSLayoutConstraint.activate([
            //containerView
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8),

            // typeImage
            typeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            typeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            typeLabel.widthAnchor.constraint(equalToConstant: 20),
            typeLabel.heightAnchor.constraint(equalToConstant: 20),

            // titleLabel
            titleLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor, constant: 32),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            // amountLabel
            amountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            amountLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor, constant: -8)
        ])
    }

    func configure(with transaction: Transaction) {
        titleLabel.text = transaction.title
        amountLabel.text = String(transaction.amount)

        if transaction.type == .expense {
            typeLabel.text = "💶"
            amountLabel.textColor = .systemRed
        } else {
            typeLabel.text = "💰"
            amountLabel.textColor = .systemGreen
        }
    }
}
