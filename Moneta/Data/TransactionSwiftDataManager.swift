import Foundation
import SwiftData

class TransactionSwiftDataManager: TransactionDatabaseManagerProtocol {

    var modelContext: ModelContext
    var modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: TransactionSwiftData.self)
            modelContext = ModelContext(modelContainer)
        } catch {
            fatalError("\(DatabaseError.buildModelContainer)")
        }
    }

    func saveTransaction(_ transaction: Transaction) {
        let transactionSwiftData = transaction.mapToSwiftData()
        modelContext.insert(transactionSwiftData)
    }

    // Devuelve las transacciones ya mapeadas
    func getTransactions() -> [Transaction] {
        do {
            let transactionSwiftDataList = try modelContext.fetch(FetchDescriptor<TransactionSwiftData>())
            return transactionSwiftDataList.map {
                $0.mapToDomainModel()
            }
        } catch {
            return []
        }
    }

    func deleteTransaction(_ transaction: Transaction) {
        guard let transactionToDelete = getTransactionToDelete(id: transaction.id) else { return }
        print("La transaccion que se ha obtenido de la base de datos tiene un id: \(transaction.id)")
        modelContext.delete(transactionToDelete)
    }

    func getTransactionToDelete(id: UUID) -> TransactionSwiftData? {
        do {
            // Se crea un predicado para filtrar las transacciones por su id
            let predicate = #Predicate<TransactionSwiftData> { transaction in
                transaction.id == id
            }

            // Configuro un FetchDescriptor con el predicado y un limite de resultados
            // Un FetchDescriptor le indica a la base de datos como debe buscar y filtrar los datos. En este caso le paso un predicado configurado de tal forma que solo obtenga las transacciones que cumplan la condicion `transaction.id == id´
            var descriptor = FetchDescriptor(predicate: predicate)
            descriptor.fetchLimit = 1

            // Realizo la busqueda en el modelContext usando el descriptor configurado. Fetch me devuelve un array de resultados que coincidan con el FetchDescriptor (predicado y limite de resultados)
            let transactions = try modelContext.fetch(descriptor)

            // Devuelve el primer (y en este caso, el unico) resuldado encontrado en el array
            return transactions.first

        } catch {
            print("error al obtener una transaccion de la base de datos")
            return nil
        }
    }

}

enum DatabaseError: Error {
    case buildModelContainer
    case getTransaction
}
