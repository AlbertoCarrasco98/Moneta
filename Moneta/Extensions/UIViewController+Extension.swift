import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ups!",
                                      message: message,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Aceptar",
                                        style: .default,
                                        handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}

extension UIColor {
    static func colorAmountLabel(transaction: Transaction) -> UIColor {
        switch transaction.type {
            case .income:
                return UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
            case .expense:
                return UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }
}
