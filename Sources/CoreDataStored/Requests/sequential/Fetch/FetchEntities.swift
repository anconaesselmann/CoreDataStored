//  Created by Axel Ancona Esselmann on 1/11/24.
//

import Foundation
import CoreData

public extension CoreDataFetchable {
    static func fetchEntities(
        withIds ids: Set<UUID>,
        in context: NSManagedObjectContext
    ) throws -> [CoreDataEntity] {
        guard let request: NSFetchRequest<CoreDataEntity> = NSManagedObject.fetchRequest() as? NSFetchRequest<CoreDataEntity> else {
            throw CoreDataError.couldNotCastFetchRequest
        }
        request.entity = NSEntityDescription.entity(
            forEntityName: "\(CoreDataEntity.self)",
            in: context
        )
        request.predicate = NSPredicate(format: "(id IN %@)", ids as CVarArg)
        return try context.fetch(request)
    }

    static func fetchEntity(
        withId id: UUID,
        in context: NSManagedObjectContext
    ) throws -> CoreDataEntity {
        guard let request: NSFetchRequest<CoreDataEntity> = NSManagedObject.fetchRequest() as? NSFetchRequest<CoreDataEntity> else {
            throw CoreDataError.couldNotCastFetchRequest
        }
        request.entity = NSEntityDescription.entity(
            forEntityName: "\(CoreDataEntity.self)",
            in: context
        )
        request.predicate = NSPredicate(format: "(id == %@)", id as CVarArg)
        guard let entity = (try context.fetch(request)).first else {
            throw CoreDataError.noResultReturned
        }
        return entity
    }
}
