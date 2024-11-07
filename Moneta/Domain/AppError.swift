import UIKit

enum AppError: LocalizedError {
    case newTransactionTitleError
    case newTransactionAmountError
    case editTitleTransactionError
    case editAmountTransactionError

    var errorDescription: String? {
        switch self {
            case .newTransactionTitleError:
                return "La transaccion debe tener un título"
            case .newTransactionAmountError:
                return "La transacción debe tener una cantidad"
            case .editTitleTransactionError:
                return "La transacción debe tener un título válido"
            case .editAmountTransactionError:
                return "La transacción debe tener una cantidad válida"
        }
    }
}
