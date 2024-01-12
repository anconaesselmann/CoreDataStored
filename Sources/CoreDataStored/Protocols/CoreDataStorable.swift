//  Created by Axel Ancona Esselmann on 9/15/23.
//

import Foundation
import CoreData

public protocol CoreDataStorable {
    associatedtype CoreDataEntity
        where CoreDataEntity: NSManagedObject
    func entity(existing entity: CoreDataEntity?, in context: NSManagedObjectContext) -> CoreDataEntity
}

public extension CoreDataStorable {
    @discardableResult
    func entity(in context: NSManagedObjectContext) -> CoreDataEntity {
        self.entity(existing: nil, in: context)
    }
}
