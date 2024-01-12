//  Created by Axel Ancona Esselmann on 1/11/24.
//

import Foundation
import CoreData

public extension CoreDataStorable where Self: CoreDataFetchable, Self: Identifiable, ID == UUID {
    @discardableResult
    func update(in context: NSManagedObjectContext) throws -> CoreDataEntity {
        let existing = try Self.fetchEntity(withId: id, in: context)
        return self.entity(existing: existing, in: context)
    }
}

public extension CoreDataFetchable where Self: Identifiable, Self.ID == UUID, Self: CoreDataStorable {

    @discardableResult
    func createOrUpdate(in context: NSManagedObjectContext) throws -> CoreDataEntity {
        do {
            let existing = try Self.fetchEntity(withId: id, in: context)
            return self.entity(existing: existing, in: context)
        } catch CoreDataError.noResultReturned {
            return self.entity(existing: nil, in: context)
        }
    }
}
