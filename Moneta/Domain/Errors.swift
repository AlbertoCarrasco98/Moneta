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
//    case saveTransaction
//    case updateTransaction
//    case getTransactions
//    case getTransactionByID
//    case deleteTransaction

    var errorDescription: String? {
        switch self {
            case .buildModelContainer:
                return "Error al construir el MoedelContainer en la base de datos"
//            case .saveTransaction:
//                return "Error al guardar una nueva transacción en la base de datos"
//            case .updateTransaction:
//                return "Error al actualizar la transacción en la base de datos"
//            case .getTransactions:
//                return "Error al obtener las transacciones de la base de datos"
//            case .getTransactionByID:
//                return "Error al obtener una transacción mediante el ID"
//            case .deleteTransaction:
//                return "Error al eliminar la transacción"
        }
    }
}

