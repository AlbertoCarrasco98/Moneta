import UIKit

extension UIColor {

    static func colorAmountLabel(transaction: Transaction) -> UIColor {
        switch transaction.type {
            case .income:
                return UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
            case .expense:
                return UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }

    enum ToastColor {
        case success
        case failure
        case `default`

        var defaultColor: UIColor {
            switch self {
                case .success:
                    return UIColor(red: 0.4, green: 0.8, blue: 0.4, alpha: 1.0)
                case .failure:
                    return UIColor(red: 0.9, green: 0.3, blue: 0.3, alpha: 1.0)
                case .default:
                    return UIColor(red: 207/255.0, green: 207/255.0, blue: 207/255.0, alpha: 1.0)
            }
        }
    }
}
