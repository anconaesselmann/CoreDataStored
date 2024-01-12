//  Created by Axel Ancona Esselmann on 1/11/24.
//

import Foundation
import CoreData

public extension CoreDataStorable where Self: CoreDataFetchable, Self: Identifiable, ID == UUID {
    @discardableResult
    func update(in context: NSManagedObjectContext) async throws -> CoreDataEntity {
        try await context.perform {
            let entity = try self.update(in: context)
            try context.save()
            return entity
        }
    }

    @discardableResult
    func createOrUpdate(in context: NSManagedObjectContext) async throws -> CoreDataEntity {
        try await context.perform {
            let entity = try self.createOrUpdate(in: context)
            try context.save()
            return entity
        }
    }
}
