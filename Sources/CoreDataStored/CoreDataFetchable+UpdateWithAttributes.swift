//  Created by Axel Ancona Esselmann on 10/13/23.
//

import CoreData

public extension CoreDataFetchable {
    @discardableResult
    internal static func update(
        itemWithId id: UUID,
        with attributes: [CoreDataAttribute],
        in context: NSManagedObjectContext,
        save: Bool = true
    ) throws -> Self {
        let entity = try Self.fetchEntity(withId: id, in: context)
        for attribute in attributes {
            entity.setValue(attribute.value, forKey: attribute.name)
        }
        if save {
            try context.save()
        }
        return try Self(entity)
    }

    @discardableResult
    static func update<T0>(
        itemWithId id: UUID,
        set
        t0: (KeyPath<CoreDataEntity, T0>, CVarArg),
        in context: NSManagedObjectContext,
        save: Bool = true
    ) throws -> Self {
        try update(
            itemWithId: id,
            with: [.keyPath(t0.0, value: t0.1)],
            in: context,
            save: save
        )
    }

    @discardableResult
    static func update<T0, T1>(
        itemWithId id: UUID,
        set
        t0: (KeyPath<CoreDataEntity, T0>, CVarArg),
        _ t1: (KeyPath<CoreDataEntity, T1>, CVarArg),
        in context: NSManagedObjectContext,
        save: Bool = true
    ) throws -> Self {
        try update(
            itemWithId: id,
            with: [
                .keyPath(t0.0, value: t0.1),
                .keyPath(t1.0, value: t1.1)
            ],
            in: context,
            save: save
        )
    }

    @discardableResult
    static func update<T0, T1, T2>(
        itemWithId id: UUID,
        set
        t0: (KeyPath<CoreDataEntity, T0>, CVarArg),
        _ t1: (KeyPath<CoreDataEntity, T1>, CVarArg),
        _ t2: (KeyPath<CoreDataEntity, T2>, CVarArg),
        in context: NSManagedObjectContext,
        save: Bool = true
    ) throws -> Self {
        try update(
            itemWithId: id,
            with: [
                .keyPath(t0.0, value: t0.1),
                .keyPath(t1.0, value: t1.1),
                .keyPath(t2.0, value: t2.1)
            ],
            in: context,
            save: save
        )
    }

    @discardableResult
    static func update<T0, T1, T2, T3>(
        itemWithId id: UUID,
        set
        t0: (KeyPath<CoreDataEntity, T0>, CVarArg),
        _ t1: (KeyPath<CoreDataEntity, T1>, CVarArg),
        _ t2: (KeyPath<CoreDataEntity, T2>, CVarArg),
        _ t3: (KeyPath<CoreDataEntity, T3>, CVarArg),
        in context: NSManagedObjectContext,
        save: Bool = true
    ) throws -> Self {
        try update(
            itemWithId: id,
            with: [
                .keyPath(t0.0, value: t0.1),
                .keyPath(t1.0, value: t1.1),
                .keyPath(t2.0, value: t2.1),
                .keyPath(t3.0, value: t3.1)
            ],
            in: context,
            save: save
        )
    }

    @discardableResult
    static func update<T0, T1, T2, T3, T4>(
        itemWithId id: UUID,
        set
        t0: (KeyPath<CoreDataEntity, T0>, CVarArg),
        _ t1: (KeyPath<CoreDataEntity, T1>, CVarArg),
        _ t2: (KeyPath<CoreDataEntity, T2>, CVarArg),
        _ t3: (KeyPath<CoreDataEntity, T3>, CVarArg),
        _ t4: (KeyPath<CoreDataEntity, T4>, CVarArg),
        in context: NSManagedObjectContext,
        save: Bool = true
    ) throws -> Self {
        try update(
            itemWithId: id,
            with: [
                .keyPath(t0.0, value: t0.1),
                .keyPath(t1.0, value: t1.1),
                .keyPath(t2.0, value: t2.1),
                .keyPath(t3.0, value: t3.1),
                .keyPath(t4.0, value: t4.1)
            ],
            in: context,
            save: save
        )
    }

    @discardableResult
    static func update<T0, T1, T2, T3, T4, T5>(
        itemWithId id: UUID,
        set
        t0: (KeyPath<CoreDataEntity, T0>, CVarArg),
        _ t1: (KeyPath<CoreDataEntity, T1>, CVarArg),
        _ t2: (KeyPath<CoreDataEntity, T2>, CVarArg),
        _ t3: (KeyPath<CoreDataEntity, T3>, CVarArg),
        _ t4: (KeyPath<CoreDataEntity, T4>, CVarArg),
        _ t5: (KeyPath<CoreDataEntity, T5>, CVarArg),
        in context: NSManagedObjectContext,
        save: Bool = true
    ) throws -> Self {
        try update(
            itemWithId: id,
            with: [
                .keyPath(t0.0, value: t0.1),
                .keyPath(t1.0, value: t1.1),
                .keyPath(t2.0, value: t2.1),
                .keyPath(t3.0, value: t3.1),
                .keyPath(t4.0, value: t4.1),
                .keyPath(t5.0, value: t5.1)
            ],
            in: context,
            save: save
        )
    }
}
