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

    @discardableResult
    func createOrUpdate<T0>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>
    ) throws -> CoreDataEntity {
        do {
            let existing = try Self.fetchEntities(in: context, where: a0)
            if existing.count > 1 {
                assertionFailure("More than one item retrieved")
            }
            return self.entity(existing: existing.first, in: context)
        } catch CoreDataError.noResultReturned {
            return self.entity(existing: nil, in: context)
        }
    }

    @discardableResult
    func createOrUpdate<SortT, T0>(
        in context: NSManagedObjectContext,
        where a0: Attribute<T0>,
        sortedBy keyPath: KP<SortT>,
        ascending: Bool = true
    ) throws -> CoreDataEntity {
        do {
            let existing = try Self.fetchEntities(
                in: context,
                where: a0,
                sortedBy: keyPath,
                ascending: ascending
            )
            if existing.count > 1 {
                assertionFailure("More than one item retrieved")
            }
            return self.entity(existing: existing.first, in: context)
        } catch CoreDataError.noResultReturned {
            return self.entity(existing: nil, in: context)
        }
    }
}
