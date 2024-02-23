//  Created by Axel Ancona Esselmann on 1/11/24.
//

import CoreData

public extension CoreDataFetchable {
    static func fetchEntities<T0>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>
    ) throws -> [CoreDataEntity] {
        try fetchEntities(
            in: context,
            where: [.keyPath(a0.0, value: a0.1)]
        )
    }
}

public extension CoreDataFetchable {

    static func fetch<T0>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>
    ) throws -> [Self] {
        try fetch(
            in: context,
            where: [.keyPath(a0.0, value: a0.1)]
        )
    }

    static func fetch<T0, T1>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
            _ a1: Attribute<T1>
    ) throws -> [Self] {
        try fetch(
            in: context,
            where: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1)
            ]
        )
    }

    static func fetch<T0, T1, T2>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
            _ a1: Attribute<T1>,
            _ a2: Attribute<T2>
    ) throws -> [Self] {
        try fetch(
            in: context,
            where: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1),
                .keyPath(a2.0, value: a2.1)
            ]
        )
    }

    static func fetch<T0, T1, T2, T3>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
            _ a1: Attribute<T1>,
            _ a2: Attribute<T2>,
            _ a3: Attribute<T3>
    ) throws -> [Self] {
        try fetch(
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

internal extension CoreDataFetchable {
    static func fetch(
        in context: NSManagedObjectContext,
        where attributes: [CoreDataAttribute]
    ) throws -> [Self] {
        guard let request: NSFetchRequest<CoreDataEntity> = NSManagedObject.fetchRequest() as? NSFetchRequest<CoreDataEntity> else {
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
                let value: CVarArg
                if let bool = $0.value as? Bool {
                    value = NSNumber(value: bool)
                } else {
                    value = $0.value as CVarArg
                }
                return NSPredicate(format: "(\($0.name) = \(insertPlaceholder))", value)
            }
        )
        request.predicate = predicateCompound
        let entities = try context.fetch(request)
        return try entities.map { try Self($0) }
    }

    static func fetchEntities(
        in context: NSManagedObjectContext,
        where attributes: [CoreDataAttribute]
    ) throws -> [CoreDataEntity] {
        guard let request: NSFetchRequest<CoreDataEntity> = NSManagedObject.fetchRequest() as? NSFetchRequest<CoreDataEntity> else {
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
        return try context.fetch(request)
    }
}
