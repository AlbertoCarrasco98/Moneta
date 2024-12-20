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

//    MARK: - Methods

    //    Guardar transacción
    func saveTransaction(_ transaction: Transaction) throws {
        let transactionSwiftData = transaction.mapToSwiftData()
        modelContext.insert(transactionSwiftData)
        try modelContext.save()
    }


    // Devuelve las transacciones ya mapeadas
    func getTransactions() throws -> [Transaction] {
        let transactionSwiftDataList = try modelContext.fetch(FetchDescriptor<TransactionSwiftData>())
        return transactionSwiftDataList.map {
            $0.mapToDomainModel()
        }
    }

    //    Obtener transacción mediante id
    func getTransactionBy(id: UUID) throws -> TransactionSwiftData? {
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
    }

    //    Actualizar transacción
    func updateTransaction(_ transaction: Transaction) throws {
        let transactionToUpdate = try getTransactionBy(id: transaction.id)
        transactionToUpdate?.type = transaction.type.mapToSwiftData()
        transactionToUpdate?.title = transaction.title
        transactionToUpdate?.amount = transaction.amount
        transactionToUpdate?.date = transaction.date
        try modelContext.save()
    }

    //    Eliminar transacción
    func deleteTransaction(_ transaction: Transaction) throws {
        if transaction.title == "Cuidao" {
            throw AppError.internalError
        }
        guard let transactionToDelete = try getTransactionBy(id: transaction.id) else { return }
        modelContext.delete(transactionToDelete)
        try modelContext.save()
    }
}
