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
        let predicate = #Predicate<TransactionSwiftData> { transaction in
            transaction.id == id
        }
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        let transactions = try modelContext.fetch(descriptor)
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
