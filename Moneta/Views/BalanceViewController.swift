import UIKit

class BalanceViewController: UIViewController {

    // mainStackView
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = UIColor.orange.cgColor
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        return stackView
    }()

    private lazy var incomeExpenseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()


    private lazy var expenseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    private lazy var expenseTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GASTOS"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.cornerRadius = 10
        return label
    }()

    private lazy var expenseAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10€"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.cornerRadius = 10
        return label
    }()

    private lazy var incomeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.borderWidth = 2
//        view.layer.borderColor = UIColor.green.cgColor
//        view.layer.cornerRadius = 10
        return view
    }()


    private lazy var incomeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "INGRESOS"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.green.cgColor
        label.layer.cornerRadius = 10
        return label
    }()

    private lazy var incomeAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15€"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.green.cgColor
        label.layer.cornerRadius = 10
        return label
    }()

    private lazy var balanceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var balanceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SALDO TOTAL"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.systemBlue.cgColor
        label.layer.cornerRadius = 10
        return label
    }()


    private lazy var balanceAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+ 5€"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
//        self.title = "BALANCE"
//        self.tabBarController?.tabBar.items?[1].title = "Balance"
        addConstraints()
    }

    private func addConstraints() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(incomeExpenseStackView)
        mainStackView.addArrangedSubview(balanceView)
        incomeExpenseStackView.addArrangedSubview(expenseView)
        incomeExpenseStackView.addArrangedSubview(incomeView)
        expenseView.addSubview(expenseTitleLabel)
        expenseView.addSubview(expenseAmountLabel)
        incomeView.addSubview(incomeTitleLabel)
        incomeView.addSubview(incomeAmountLabel)
        balanceView.addSubview(balanceTitleLabel)
        balanceView.addSubview(balanceAmountLabel)

        NSLayoutConstraint.activate([

            // mainStackView
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            view.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 48),
            view.bottomAnchor.constraint(equalTo: mainStackView.safeAreaLayoutGuide.bottomAnchor, constant: 250),

            // expenseTitleLabel
            expenseTitleLabel.leadingAnchor.constraint(equalTo: expenseView.leadingAnchor, constant: 36),
            expenseTitleLabel.topAnchor.constraint(equalTo: expenseView.topAnchor, constant: 25),
            expenseView.trailingAnchor.constraint(equalTo: expenseTitleLabel.trailingAnchor, constant: 36),
            expenseView.bottomAnchor.constraint(equalTo: expenseTitleLabel.bottomAnchor, constant: 135),

            // incomeTitleLabel
            incomeTitleLabel.leadingAnchor.constraint(equalTo: incomeView.leadingAnchor, constant: 30),
            incomeTitleLabel.topAnchor.constraint(equalTo: incomeView.topAnchor, constant: 25),
            incomeView.trailingAnchor.constraint(equalTo: incomeTitleLabel.trailingAnchor, constant: 30),
            incomeView.bottomAnchor.constraint(equalTo: incomeTitleLabel.bottomAnchor, constant: 135),

            // expenseAmountLabel
            expenseAmountLabel.leadingAnchor.constraint(equalTo: expenseView.leadingAnchor, constant: 37),
            expenseAmountLabel.topAnchor.constraint(equalTo: expenseView.topAnchor, constant: 135),
            expenseView.trailingAnchor.constraint(equalTo: expenseAmountLabel.trailingAnchor, constant: 37),
            expenseView.bottomAnchor.constraint(equalTo: expenseAmountLabel.bottomAnchor, constant: 25),

            // incomeAmountLabel
            incomeAmountLabel.leadingAnchor.constraint(equalTo: incomeView.leadingAnchor, constant: 37),
            incomeAmountLabel.topAnchor.constraint(equalTo: incomeView.topAnchor, constant: 135),
            incomeView.trailingAnchor.constraint(equalTo: incomeAmountLabel.trailingAnchor, constant: 37),
            incomeView.bottomAnchor.constraint(equalTo: incomeAmountLabel.bottomAnchor, constant: 25),

            // balanceTitleLabel
            balanceTitleLabel.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor, constant: 48),
            balanceTitleLabel.topAnchor.constraint(equalTo: balanceView.topAnchor, constant: 32),
            balanceView.trailingAnchor.constraint(equalTo: balanceTitleLabel.trailingAnchor, constant: 48),
            balanceTitleLabel.heightAnchor.constraint(equalToConstant: 50),

            // balanceAmountLabel
            balanceAmountLabel.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor, constant: 56),
            balanceView.trailingAnchor.constraint(equalTo: balanceAmountLabel.trailingAnchor, constant: 56),
            balanceView.bottomAnchor.constraint(equalTo: balanceAmountLabel.bottomAnchor, constant: 32),
            balanceAmountLabel.heightAnchor.constraint(equalToConstant: 50)

        ])
    }

}
