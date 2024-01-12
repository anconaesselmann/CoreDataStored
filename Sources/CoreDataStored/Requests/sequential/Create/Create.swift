//  Created by Axel Ancona Esselmann on 1/11/24.
//

import Foundation
import CoreData

public extension CoreDataFetchable where Self: Identifiable, Self.ID == UUID, Self: CoreDataStorable {
    @discardableResult
    func createIfNew(in context: NSManagedObjectContext) throws -> CoreDataEntity {
        do {
            return try Self.fetchEntity(withId: id, in: context)
        } catch CoreDataError.noResultReturned {
            return self.entity(existing: nil, in: context)
        }
    }
}
