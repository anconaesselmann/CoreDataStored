//  Created by Axel Ancona Esselmann on 10/25/23.
//

import CoreData

public extension CoreDataFetchable {

    static func fetch<T0>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>
    ) async throws -> [Self] {
        try await fetch(
            in: context,
            where: [.keyPath(a0.0, value: a0.1)]
        )
    }

    static func fetch<T0, T1>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
            _ a1: Attribute<T1>
    ) async throws -> [Self] {
        try await fetch(
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
    ) async throws -> [Self] {
        try await fetch(
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
    ) async throws -> [Self] {
        try await fetch(
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
    ) async throws -> [Self] {
        try await context.perform {
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
                    NSPredicate(format: "(\($0.name) = %@)", $0.value as CVarArg)
                }
            )
            request.predicate = predicateCompound
            let entities = try context.fetch(request)
            return try entities.map { try Self($0) }
        }
    }
}
