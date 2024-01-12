//  Created by Axel Ancona Esselmann on 1/11/24.
//

import Foundation
import CoreData

public extension CoreDataFetchable {
    @discardableResult
    static func toggle(
        _ keyPath: KeyPath<CoreDataEntity, Bool>,
        itemWithId id: UUID,
        in context: NSManagedObjectContext,
        save: Bool = true
    ) async throws -> Self {
        try await context.perform {
            try toggle(keyPath, itemWithId: id, in: context, save: save)
        }
    }
}
