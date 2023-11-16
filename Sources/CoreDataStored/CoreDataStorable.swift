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

    @discardableResult
    func createIfNew(in context: NSManagedObjectContext) async throws -> CoreDataEntity {
        try await context.perform {
            let entity = try self.createIfNew(in: context)
            try context.save()
            return entity
        }
    }
}
