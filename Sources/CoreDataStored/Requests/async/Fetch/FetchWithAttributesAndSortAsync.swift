//  Created by Axel Ancona Esselmann on 10/25/23.
//

import CoreData

public extension CoreDataFetchable {

    static func fetch<SortT, T0>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
        sortedBy keyPath: KP<SortT>,
        ascending: Bool = true,
        fetchLimit: Int? = nil
    ) async throws -> [Self] {
        try await fetch(
            in: context,
            where: [.keyPath(a0.0, value: a0.1)],
            sortedBy: keyPath,
            ascending: ascending,
            fetchLimit: fetchLimit
        )
    }

    static func fetch<SortT, T0, T1>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
            _ a1: Attribute<T1>,
        sortedBy keyPath: KP<SortT>,
        ascending: Bool = true,
        fetchLimit: Int? = nil
    ) async throws -> [Self] {
        try await fetch(
            in: context,
            where: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1)
            ],
            sortedBy: keyPath,
            ascending: ascending,
            fetchLimit: fetchLimit
        )
    }

    static func fetch<SortT, T0, T1, T2>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
            _ a1: Attribute<T1>,
            _ a2: Attribute<T2>,
        sortedBy keyPath: KP<SortT>,
        ascending: Bool = true,
        fetchLimit: Int? = nil
    ) async throws -> [Self] {
        try await fetch(
            in: context,
            where: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1),
                .keyPath(a2.0, value: a2.1)
            ],
            sortedBy: keyPath,
            ascending: ascending,
            fetchLimit: fetchLimit
        )
    }

    static func fetch<SortT, T0, T1, T2, T3>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
            _ a1: Attribute<T1>,
            _ a2: Attribute<T2>,
            _ a3: Attribute<T3>,
        sortedBy keyPath: KP<SortT>,
        ascending: Bool = true,
        fetchLimit: Int? = nil
    ) async throws -> [Self] {
        try await fetch(
            in: context,
            where: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1),
                .keyPath(a2.0, value: a2.1),
                .keyPath(a3.0, value: a3.1)
            ],
            sortedBy: keyPath,
            ascending: ascending,
            fetchLimit: fetchLimit
        )
    }
}

fileprivate extension CoreDataFetchable {
    static func fetch<T>(
        in context: NSManagedObjectContext,
        where attributes: [CoreDataAttribute],
        sortedBy keyPath: KP<T>,
        ascending: Bool = true,
        fetchLimit: Int? = nil
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
            if let fetchLimit = fetchLimit {
                request.fetchLimit = fetchLimit
            }
            request.predicate = predicateCompound
            request.sortDescriptors = [NSSortDescriptor(keyPath: keyPath, ascending: ascending)]
            let entities = try context.fetch(request)
            return try entities.map { try Self($0) }
        }
    }
}
