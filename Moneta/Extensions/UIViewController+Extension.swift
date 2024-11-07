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
