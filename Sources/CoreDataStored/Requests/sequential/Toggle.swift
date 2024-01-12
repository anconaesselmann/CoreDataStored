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
    ) throws -> Self {
        let entity = try Self.fetchEntity(withId: id, in: context)
        let current = entity[keyPath: keyPath]
        entity.setValue(!current, forKey: keyPath.propertyAsString)
        if save {
            try context.save()
        }
        return try Self(entity)
    }
}
