//  Created by Axel Ancona Esselmann on 10/13/23.
//

import Foundation
import CoreData

public extension CoreDataFetchable {

    init<T0>(
        with a0: Attribute<T0>,
        in context: NSManagedObjectContext
    ) throws {
        try self.init(
            with: [.keyPath(a0.0, value: a0.1)],
            in: context
        )
    }

    init<T0, T1>(
        with a0: Attribute<T0>,
           _ a1: Attribute<T1>,
        in context: NSManagedObjectContext
    ) throws {
        try self.init(
            with: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1)
            ],
            in: context
        )
    }

    init<T0, T1, T2>(
        with a0: Attribute<T0>,
           _ a1: Attribute<T1>,
           _ a2: Attribute<T2>,
        in context: NSManagedObjectContext
    ) throws {
        try self.init(
            with: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1),
                .keyPath(a2.0, value: a2.1)
            ],
            in: context
        )
    }

    init<T0, T1, T2, T3>(
        with a0: Attribute<T0>,
           _ a1: Attribute<T1>,
           _ a2: Attribute<T2>,
           _ a3: Attribute<T3>,
        in context: NSManagedObjectContext
    ) throws {
        try self.init(
            with: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1),
                .keyPath(a2.0, value: a2.1),
                .keyPath(a3.0, value: a3.1)
            ],
            in: context
        )
    }
}

internal extension CoreDataFetchable {
    init(
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
}
