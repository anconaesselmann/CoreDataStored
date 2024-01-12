//  Created by Axel Ancona Esselmann on 1/11/24.
//

import Foundation
import CoreData

public extension CoreDataStorable {
    @discardableResult
    func create(in context: NSManagedObjectContext) async throws -> CoreDataEntity {
        try await context.perform {
            let entity = self.entity(existing: nil, in: context)
            try context.save()
            return entity
        }
    }
}

public extension CoreDataFetchable where Self: Identifiable, Self.ID == UUID, Self: CoreDataStorable {
    @discardableResult
    func createIfNew(in context: NSManagedObjectContext) async throws -> CoreDataEntity {
        try await context.perform {
            let entity = try self.createIfNew(in: context)
            try context.save()
            return entity
        }
    }
}
