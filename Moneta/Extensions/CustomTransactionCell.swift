import UIKit

class CustomTransactionwCell: UITableViewCell {

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

    let typeImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(typeImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(amountLabel)

        NSLayoutConstraint.activate([
            // typeImage
            typeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            typeImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            typeImage.widthAnchor.constraint(equalToConstant: 20),
            typeImage.heightAnchor.constraint(equalToConstant: 20),

            // titleLabel
            titleLabel.leadingAnchor.constraint(equalTo: typeImage.leadingAnchor, constant: 32),
//            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            // amountLabel
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor, constant: -8)
        ])
    }

    func configure(with transaction: Transaction) {
        titleLabel.text = transaction.title
        amountLabel.text = String(transaction.amount)

        if transaction.type == .expense {
            typeImage.image = UIImage(systemName: "minus.circle.fill")
            typeImage.tintColor = .systemRed
        } else {
            typeImage.image = UIImage(systemName: "plus.circle.fill")
            typeImage.tintColor = .systemGreen
        }
    }

    private func configureDateString(for transaction: Transaction) -> String {
        let date = transaction.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
