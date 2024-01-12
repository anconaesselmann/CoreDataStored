//  Created by Axel Ancona Esselmann on 1/11/24.
//

import Foundation
import CoreData

public extension CoreDataFetchable {
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
}
