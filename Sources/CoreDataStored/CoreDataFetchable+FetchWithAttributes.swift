//  Created by Axel Ancona Esselmann on 10/13/23.
//

import Foundation
import CoreData

public extension CoreDataFetchable {
    internal init(
        with attributes: [CoreDataAttribute],
        in context: NSManagedObjectContext
    ) throws {
        guard let request = NSManagedObject.fetchRequest() as? NSFetchRequest<CoreDataEntity> else {
            throw CoreDataError.couldNotCastFetchRequest
        }
        request.entity = NSEntityDescription.entity(
            forEntityName: "\(CoreDataEntity.self)",
            in: context
        )
        let predicateCompound = NSCompoundPredicate(
            type: .and,
            subpredicates: attributes.map {
                NSPredicate(format: "(\($0.name) = %@)", $0.value)
            }
        )
        request.predicate = predicateCompound
        request.fetchLimit = 1
        guard let entity: CoreDataEntity = try context.fetch(request).first else {
            throw CoreDataError.noResultReturned
        }
        try self.init(entity)
    }

    init<T0>(
        with t0: (KeyPath<CoreDataEntity, T0>, CVarArg),
        in context: NSManagedObjectContext
    ) throws {
        try self.init(
            with: [.keyPath(t0.0, value: t0.1)],
            in: context
        )
    }

    init<T0, T1>(
        with t0: (KeyPath<CoreDataEntity, T0>, CVarArg),
        _ t1: (KeyPath<CoreDataEntity, T1>, CVarArg),
        in context: NSManagedObjectContext
    ) throws {
        try self.init(
            with: [
                .keyPath(t0.0, value: t0.1),
                .keyPath(t1.0, value: t1.1)
            ],
            in: context
        )
    }

    init<T0, T1, T2>(
        with t0: (KeyPath<CoreDataEntity, T0>, CVarArg),
        _ t1: (KeyPath<CoreDataEntity, T1>, CVarArg),
        _ t2: (KeyPath<CoreDataEntity, T2>, CVarArg),
        in context: NSManagedObjectContext
    ) throws {
        try self.init(
            with: [
                .keyPath(t0.0, value: t0.1),
                .keyPath(t1.0, value: t1.1),
                .keyPath(t2.0, value: t2.1)
            ],
            in: context
        )
    }

    init<T0, T1, T2, T3>(
        with t0: (KeyPath<CoreDataEntity, T0>, CVarArg),
        _ t1: (KeyPath<CoreDataEntity, T1>, CVarArg),
        _ t2: (KeyPath<CoreDataEntity, T2>, CVarArg),
        _ t3: (KeyPath<CoreDataEntity, T3>, CVarArg),
        in context: NSManagedObjectContext
    ) throws {
        try self.init(
            with: [
                .keyPath(t0.0, value: t0.1),
                .keyPath(t1.0, value: t1.1),
                .keyPath(t2.0, value: t2.1),
                .keyPath(t3.0, value: t3.1)
            ],
            in: context
        )
    }
}
