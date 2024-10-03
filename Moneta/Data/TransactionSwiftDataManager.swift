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
            fatalError("Error configurando el modelContainer: \(error)")
        }
    }

    func saveTransaction(_ transaction: Transaction) {
        let transactionSwiftData = transaction.mapToSwiftData()
        modelContext.insert(transactionSwiftData)
    }

    func getTransaction() -> [Transaction] {
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
        let transactionSwiftData = transaction.mapToSwiftData()
        modelContext.delete(transactionSwiftData)
    }
}

enum DatabaseError: Error {
    case buildModelContainer
}
