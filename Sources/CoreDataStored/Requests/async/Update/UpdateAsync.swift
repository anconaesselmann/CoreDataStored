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

public extension CoreDataFetchable where Self: Identifiable, Self.ID == UUID, Self: CoreDataStorable {

    @discardableResult
    func createOrUpdate_async<T0>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>
    ) async throws -> CoreDataEntity {
        try await context.perform {
            try self.createOrUpdate(in: context, where: a0)
        }
    }

    @discardableResult
    func createOrUpdate<SortT, T0>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
        sortedBy keyPath: KP<SortT>,
        ascending: Bool = true
    ) async throws -> CoreDataEntity {
        try await context.perform {
            try createOrUpdate(in: context, where: a0, sortedBy: keyPath, ascending: ascending)
        }
    }
}
