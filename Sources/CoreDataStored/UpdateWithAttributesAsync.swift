//  Created by Axel Ancona Esselmann on 10/25/23.
//

import CoreData

public extension CoreDataFetchable {

    @discardableResult
    static func update<T0>(
        itemWithId id: UUID,
        set a0: Attribute<T0>,
        in context: NSManagedObjectContext,
        save: Bool = true
    ) async throws -> Self {
        try await update(
            itemWithId: id,
            with: [.keyPath(a0.0, value: a0.1)],
            in: context,
            save: save
        )
    }

    @discardableResult
    static func update<T0, T1>(
        itemWithId id: UUID,
        set a0: Attribute<T0>,
          _ a1: Attribute<T1>,
        in context: NSManagedObjectContext,
        save: Bool = true
    ) async throws -> Self {
        try await  update(
            itemWithId: id,
            with: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1)
            ],
            in: context,
            save: save
        )
    }

    @discardableResult
    static func update<T0, T1, T2>(
        itemWithId id: UUID,
        set a0: Attribute<T0>,
          _ a1: Attribute<T1>,
          _ a2: Attribute<T2>,
        in context: NSManagedObjectContext,
        save: Bool = true
    ) async throws -> Self {
        try await  update(
            itemWithId: id,
            with: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1),
                .keyPath(a2.0, value: a2.1)
            ],
            in: context,
            save: save
        )
    }

    @discardableResult
    static func update<T0, T1, T2, T3>(
        itemWithId id: UUID,
        set a0: Attribute<T0>,
          _ a1: Attribute<T1>,
          _ a2: Attribute<T2>,
          _ a3: Attribute<T3>,
        in context: NSManagedObjectContext,
        save: Bool = true
    ) async throws -> Self {
        try await  update(
            itemWithId: id,
            with: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1),
                .keyPath(a2.0, value: a2.1),
                .keyPath(a3.0, value: a3.1)
            ],
            in: context,
            save: save
        )
    }

    @discardableResult
    static func update<T0, T1, T2, T3, T4>(
        itemWithId id: UUID,
        set a0: Attribute<T0>,
          _ a1: Attribute<T1>,
          _ a2: Attribute<T2>,
          _ a3: Attribute<T3>,
          _ a4: Attribute<T4>,
        in context: NSManagedObjectContext,
        save: Bool = true
    ) async throws -> Self {
        try await  update(
            itemWithId: id,
            with: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1),
                .keyPath(a2.0, value: a2.1),
                .keyPath(a3.0, value: a3.1),
                .keyPath(a4.0, value: a4.1)
            ],
            in: context,
            save: save
        )
    }

    @discardableResult
    static func update<T0, T1, T2, T3, T4, T5>(
        itemWithId id: UUID,
        set a0: Attribute<T0>,
          _ a1: Attribute<T1>,
          _ a2: Attribute<T2>,
          _ a3: Attribute<T3>,
          _ a4: Attribute<T4>,
          _ a5: Attribute<T5>,
        in context: NSManagedObjectContext,
        save: Bool = true
    ) async throws -> Self {
        try await  update(
            itemWithId: id,
            with: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1),
                .keyPath(a2.0, value: a2.1),
                .keyPath(a3.0, value: a3.1),
                .keyPath(a4.0, value: a4.1),
                .keyPath(a5.0, value: a5.1)
            ],
            in: context,
            save: save
        )
    }
}

internal extension CoreDataFetchable {
    @discardableResult
    static func update(
        itemWithId id: UUID,
        with attributes: [CoreDataAttribute],
        in context: NSManagedObjectContext,
        save: Bool = true
    ) async throws -> Self {
        try await context.perform {
            let entity = try Self.fetchEntity(withId: id, in: context)
            for attribute in attributes {
                entity.setValue(attribute.value, forKey: attribute.name)
            }
            if save {
                try context.save()
            }
            return try Self(entity)
        }
    }
}
