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
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var expensesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "GASTOS"
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()

    private lazy var expensesAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()

    private lazy var incomesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "INGRESOS"
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()


    private lazy var incomesAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()

    private lazy var balanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "BALANCE TOTAL"
        label.font = .systemFont(ofSize: 35)
        label.textAlignment = .center

        return label
    }()

    private lazy var balanceAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateExpensesAmountLabel()
        updateIncomesAmountLabel()
        updateBalanceAmountLabel()
    }

    private func setupUI() {
        view.backgroundColor = .white
        addConstraints()
    }

    private func updateExpensesAmountLabel() {
        let totalExpenses = viewModel.calculateTotalExpenses()
        expensesAmountLabel.text = "\(totalExpenses)€"
    }

    private func updateIncomesAmountLabel() {
        let totalIncomes = viewModel.calculateTotalIncomes()
        incomesAmountLabel.text = "\(totalIncomes)€"
    }

    private func updateBalanceAmountLabel() {
        let balance = viewModel.calculateTotalBalance()
        balanceAmountLabel.text = "\(balance)€"

        if balance < 0 {
            balanceAmountLabel.textColor = .red
        } else {
            balanceAmountLabel.textColor = .green
        }
        if balance == 0 {
            balanceAmountLabel.textColor = .black
        }
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
