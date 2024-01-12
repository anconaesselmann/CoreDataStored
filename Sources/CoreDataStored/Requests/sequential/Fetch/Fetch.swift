//  Created by Axel Ancona Esselmann on 1/11/24.
//

import Foundation
import CoreData

public extension CoreDataFetchable {
    init(
        id: UUID,
        in context: NSManagedObjectContext
    ) throws {
        guard let request = NSManagedObject.fetchRequest() as? NSFetchRequest<CoreDataEntity> else {
            throw CoreDataError.couldNotCastFetchRequest
        }
        request.entity = NSEntityDescription.entity(
            forEntityName: "\(CoreDataEntity.self)",
            in: context
        )
        request.predicate = NSPredicate(format: "(id = %@)", id as CVarArg)
        request.fetchLimit = 1
        guard let entity: CoreDataEntity = try context.fetch(request).first else {
            throw CoreDataError.noResultReturned
        }
        try self.init(entity)
    }

    init?(
        optionalId: UUID?,
        in context: NSManagedObjectContext
    ) throws {
        guard let id = optionalId else {
            return nil
        }
        try self.init(id: id, in: context)
    }

    static func fetchAll(in context: NSManagedObjectContext) throws -> [Self] {
        guard let request: NSFetchRequest<CoreDataEntity> = NSManagedObject.fetchRequest() as? NSFetchRequest<CoreDataEntity> else {
            throw CoreDataError.couldNotCastFetchRequest
        }
        request.entity = NSEntityDescription.entity(
            forEntityName: "\(CoreDataEntity.self)",
            in: context
        )
        let entities = try context.fetch(request)
        return try entities.map { try Self($0) }
    }

    static func fetchAll<T>(
        in context: NSManagedObjectContext,
        sortedBy keyPath: KeyPath<CoreDataEntity, T>,
        ascending: Bool = true
    ) throws -> [Self] {
        guard let request: NSFetchRequest<CoreDataEntity> = NSManagedObject.fetchRequest() as? NSFetchRequest<CoreDataEntity> else {
            throw CoreDataError.couldNotCastFetchRequest
        }
        request.entity = NSEntityDescription.entity(
            forEntityName: "\(CoreDataEntity.self)",
            in: context
        )
        request.sortDescriptors = [NSSortDescriptor(keyPath: keyPath, ascending: ascending)]
        let entities = try context.fetch(request)
        return try entities.map { try Self($0) }
    }
}
