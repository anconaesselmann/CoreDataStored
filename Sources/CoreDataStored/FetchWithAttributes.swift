//  Created by Axel Ancona Esselmann on 10/13/23.
//

import Foundation
import CoreData

public extension CoreDataFetchable {

    init<T0>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>
    ) throws {
        try self.init(
            in: context,
            where: [.keyPath(a0.0, value: a0.1)]
        )
    }

    init<T0, T1>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
            _ a1: Attribute<T1>
    ) throws {
        try self.init(
            in: context,
            where: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1)
            ]
        )
    }

    init<T0, T1, T2>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
            _ a1: Attribute<T1>,
            _ a2: Attribute<T2>
    ) throws {
        try self.init(
            in: context,
            where: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1),
                .keyPath(a2.0, value: a2.1)
            ]
        )
    }

    init<T0, T1, T2, T3>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
            _ a1: Attribute<T1>,
            _ a2: Attribute<T2>,
            _ a3: Attribute<T3>
    ) throws {
        try self.init(
            in: context,
            where: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1),
                .keyPath(a2.0, value: a2.1),
                .keyPath(a3.0, value: a3.1)
            ]
        )
    }
}

fileprivate extension CoreDataFetchable {
    init(
        in context: NSManagedObjectContext,
        where attributes: [CoreDataAttribute]
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
                let insertPlaceholder: String
                switch $0.value {
                case is Int, is Int8, is Int16:
                    insertPlaceholder = "%i"
                default:
                    insertPlaceholder = "%@"
                }
                return NSPredicate(format: "(\($0.name) = \(insertPlaceholder))", $0.value)
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
