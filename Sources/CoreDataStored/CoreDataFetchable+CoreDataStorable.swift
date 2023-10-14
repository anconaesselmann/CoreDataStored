//  Created by Axel Ancona Esselmann on 9/15/23.
//

import Foundation
import CoreData

public extension CoreDataFetchable where Self: Identifiable, Self.ID == UUID, Self: CoreDataStorable {
    func update(in context: NSManagedObjectContext) throws -> CoreDataEntity {
        let existing = try Self.fetchEntity(withId: id, in: context)
        return self.entity(existing: existing, in: context)
    }
}
