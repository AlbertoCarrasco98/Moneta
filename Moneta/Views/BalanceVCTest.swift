import UIKit

class BalanceViewController: UIViewController {

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            expensesIncomesStackView,
            balanceStackView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        return stackView
    }()

    private lazy var expensesIncomesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            expensesStackView,
            incomesStackView
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var expensesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .vertical, space: 64),
            expensesTitleLabel,
            SpacerView(axis: .vertical, space: 150),
            expensesAmountLabel,
            UIView()
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .green
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var incomesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .vertical, space: 64),
            incomesTitleLabel,
            SpacerView(axis: .vertical, space: 150),
            incomesAmountLabel,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.backgroundColor = .brown
        return stackView
    }()

    private lazy var balanceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .vertical, space: 64),
            balanceTitleLabel,
            SpacerView(axis: .vertical, space: 128),
            balanceAmountLabel,
            UIView()
        ])
        stackView.backgroundColor = .systemPink
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var expensesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "expenses title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .cyan
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 28)

        return label
    }()

    private lazy var expensesAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "expenses amount"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .yellow
        label.textAlignment = .center
        return label
    }()

    private lazy var incomesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "incomes title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()


    private lazy var incomesAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "incomes amount"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private lazy var balanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "balance title"
        label.textAlignment = .center

        return label
    }()

    private lazy var balanceAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "balance amount"
        label.textAlignment = .center

        return label
    }()

    private let viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        addConstraints()
    }

    private func addConstraints() {
        view.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
