import UIKit

enum AppError: LocalizedError {
    case internalError
    case newTransactionTitleError
    case newTransactionAmountError
    case editTitleTransactionError
    case editAmountTransactionError
    
    var errorDescription: String? {
        switch self {
            case .internalError:
                return "Ups... Algo ha fallado"
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

enum DatabaseError: LocalizedError {
    case buildModelContainer
    
    var errorDescription: String? {
        switch self {
            case .buildModelContainer:
                return "Error al construir el MoedelContainer en la base de datos"
        }
    }
}

