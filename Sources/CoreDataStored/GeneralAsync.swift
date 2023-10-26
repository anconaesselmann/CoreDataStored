//  Created by Axel Ancona Esselmann on 10/25/23.
//

import Foundation
import CoreData

public extension CoreDataFetchable {
    static func fetchAll(in context: NSManagedObjectContext) async throws -> [Self] {
        try await context.perform {
            try Self.fetchAll(in: context)
        }
    }

    static func fetchAll<T>(
        in context: NSManagedObjectContext,
        sortedBy keyPath: KeyPath<CoreDataEntity, T>,
        ascending: Bool = true
    ) async throws -> [Self] {
        try await context.perform {
            try Self.fetchAll(
                in: context,
                sortedBy: keyPath,
                ascending: ascending
            )
        }
    }

    static func fetchEntities(
        withIds ids: Set<UUID>,
        in context: NSManagedObjectContext
    ) async throws -> [CoreDataEntity] {
        try await context.perform {
            try fetchEntities(
                withIds: ids,
                in: context
            )
        }
    }

    static func fetchEntity(
        withId id: UUID,
        in context: NSManagedObjectContext
    ) async throws -> CoreDataEntity {
        try await context.perform {
            try fetchEntity(
                withId: id,
                in: context
            )
        }
    }

    static func fetch(
        id: UUID,
        in context: NSManagedObjectContext
    ) async throws -> Self {
        try await context.perform {
            try Self(id: id, in: context)
        }
    }

    static func fetch(
        optionalId: UUID?,
        in context: NSManagedObjectContext
    ) async throws -> Self? {
        try await context.perform {
            try Self(optionalId: optionalId, in: context)
        }
    }

    @discardableResult
    static func delete(
        id: UUID,
        in context: NSManagedObjectContext,
        save: Bool = true
    ) async throws -> Self {
        try await context.perform {
            try delete(
               id: id,
               in: context,
               save: save
           )
        }
    }

    @discardableResult
    static func update<T>(
        itemWithId id: UUID,
        in context: NSManagedObjectContext,
        set keyPath: KeyPath<CoreDataEntity, T>,
        to value: T,
        save: Bool = true
    ) async throws -> Self {
        try await context.perform {
            try update(
                itemWithId: id,
                in: context,
                set: keyPath,
                to: value,
                save: save
            )
        }
    }

    static func hasEntries(in context: NSManagedObjectContext) async throws -> Bool {
        try await context.perform {
            try hasEntries(in: context)
        }
    }
    
    static func count(in context: NSManagedObjectContext) async throws -> Int {
        try await context.perform {
            try count(in: context)
        }
    }
}
