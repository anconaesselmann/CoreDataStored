//  Created by Axel Ancona Esselmann on 1/11/24.
//

import Foundation
import CoreData

public extension CoreDataFetchable {
    @discardableResult
    static func delete(
        id: UUID,
        in context: NSManagedObjectContext,
        save: Bool = true
    ) throws -> Self {
        let entity = try fetchEntity(withId: id, in: context)
        let element = try Self(entity)
        context.delete(entity)
        if save {
            try context.save()
        }
        return element
    }
}
