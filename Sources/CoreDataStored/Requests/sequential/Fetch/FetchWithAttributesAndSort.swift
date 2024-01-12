//  Created by Axel Ancona Esselmann on 10/25/23.
//

import CoreData

public extension CoreDataFetchable {

    static func fetch<SortT, T0>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
        sortedBy keyPath: KP<SortT>,
        ascending: Bool = true
    ) throws -> [Self] {
        try fetch(
            in: context,
            where: [.keyPath(a0.0, value: a0.1)],
            sortedBy: keyPath,
            ascending: ascending
        )
    }

    static func fetch<SortT, T0, T1>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
            _ a1: Attribute<T1>,
        sortedBy keyPath: KP<SortT>,
        ascending: Bool = true
    ) throws -> [Self] {
        try fetch(
            in: context,
            where: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1)
            ],
            sortedBy: keyPath,
            ascending: ascending
        )
    }

    static func fetch<SortT, T0, T1, T2>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
            _ a1: Attribute<T1>,
            _ a2: Attribute<T2>,
        sortedBy keyPath: KP<SortT>,
        ascending: Bool = true
    ) throws -> [Self] {
        try fetch(
            in: context,
            where: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1),
                .keyPath(a2.0, value: a2.1)
            ],
            sortedBy: keyPath,
            ascending: ascending
        )
    }

    static func fetch<SortT, T0, T1, T2, T3>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
            _ a1: Attribute<T1>,
            _ a2: Attribute<T2>,
            _ a3: Attribute<T3>,
        sortedBy keyPath: KP<SortT>,
        ascending: Bool = true
    ) throws -> [Self] {
        try fetch(
            in: context,
            where: [
                .keyPath(a0.0, value: a0.1),
                .keyPath(a1.0, value: a1.1),
                .keyPath(a2.0, value: a2.1),
                .keyPath(a3.0, value: a3.1)
            ],
            sortedBy: keyPath,
            ascending: ascending
        )
    }
}

internal extension CoreDataFetchable {
    static func fetch<T>(
        in context: NSManagedObjectContext,
        where attributes: [CoreDataAttribute],
        sortedBy keyPath: KP<T>,
        ascending: Bool = true
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
                NSPredicate(format: "(\($0.name) = %@)", $0.value)
            }
        )
        request.predicate = predicateCompound
        request.sortDescriptors = [NSSortDescriptor(keyPath: keyPath, ascending: ascending)]
        let entities = try context.fetch(request)
        return try entities.map { try Self($0) }
    }
}
