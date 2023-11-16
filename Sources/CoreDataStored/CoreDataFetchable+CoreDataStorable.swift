//  Created by Axel Ancona Esselmann on 9/15/23.
//

import Foundation
import CoreData

public extension CoreDataFetchable where Self: Identifiable, Self.ID == UUID, Self: CoreDataStorable {

    @discardableResult
    func update(in context: NSManagedObjectContext) throws -> CoreDataEntity {
        let existing = try Self.fetchEntity(withId: id, in: context)
        return self.entity(existing: existing, in: context)
    }

    @discardableResult
    func createOrUpdate(in context: NSManagedObjectContext) throws -> CoreDataEntity {
        do {
            let existing = try Self.fetchEntity(withId: id, in: context)
            return self.entity(existing: existing, in: context)
        } catch CoreDataError.noResultReturned {
            return self.entity(existing: nil, in: context)
        }
    }

    @discardableResult
    func createIfNew(in context: NSManagedObjectContext) throws -> CoreDataEntity {
        do {
            return try Self.fetchEntity(withId: id, in: context)
        } catch CoreDataError.noResultReturned {
            return self.entity(existing: nil, in: context)
        }
    }
}
