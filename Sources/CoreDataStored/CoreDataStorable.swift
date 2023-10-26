//  Created by Axel Ancona Esselmann on 9/15/23.
//

import Foundation
import CoreData

public protocol CoreDataStorable {
    associatedtype CoreDataEntity
        where CoreDataEntity: NSManagedObject
    func entity(existing entity: CoreDataEntity?, in context: NSManagedObjectContext) -> CoreDataEntity
}

public extension CoreDataStorable {
    @discardableResult
    func entity(in context: NSManagedObjectContext) -> CoreDataEntity {
        self.entity(existing: nil, in: context)
    }

    @discardableResult
    func create(in context: NSManagedObjectContext) async throws -> CoreDataEntity {
        try await context.perform {
            let entity = self.entity(existing: nil, in: context)
            try context.save()
            return entity
        }
    }
}

extension CoreDataStorable where Self: CoreDataFetchable, Self: Identifiable, ID == UUID {
    @discardableResult
    func update(in context: NSManagedObjectContext) async throws -> CoreDataEntity {
        try await context.perform {
            var existing = try Self.fetchEntity(withId: id, in: context)
            let updated = self.entity(existing: existing, in: context)
            try context.save()
            return updated
        }
    }

    @discardableResult
    func createOrUpdate(in context: NSManagedObjectContext) async throws -> CoreDataEntity {
        try await context.perform {
            let existing = try? Self.fetchEntity(withId: id, in: context)
            let entity = self.entity(existing: existing, in: context)
            try context.save()
            return entity
        }
    }

    @discardableResult
    func createIfNew(in context: NSManagedObjectContext) async throws -> CoreDataEntity {
        try await context.perform {
            if let existing = try? Self.fetchEntity(withId: id, in: context) {
                return existing
            }
            let entity = self.entity(existing: nil, in: context)
            try context.save()
            return entity
        }
    }
}
