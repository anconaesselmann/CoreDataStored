//  Created by Axel Ancona Esselmann on 1/11/24.
//

import Foundation
import CoreData

public extension CoreDataFetchable {
    static func fetchEntities(
        withIds ids: Set<UUID>,
        in context: NSManagedObjectContext
    ) async throws -> [CoreDataEntity] {
        try await context.perform {
            try fetchEntities(
                withIds: ids,
                in: context
            )
        }
    }

    static func fetchEntity(
        withId id: UUID,
        in context: NSManagedObjectContext
    ) async throws -> CoreDataEntity {
        try await context.perform {
            try fetchEntity(
                withId: id,
                in: context
            )
        }
    }
}
