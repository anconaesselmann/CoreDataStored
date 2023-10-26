//  Created by Axel Ancona Esselmann on 10/25/23.
//

import Foundation
import CoreData

public extension CoreDataFetchable {
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

    @discardableResult
    static func update<T>(
        itemWithId id: UUID,
        in context: NSManagedObjectContext,
        set keyPath: KeyPath<CoreDataEntity, T>,
        to value: T,
        save: Bool = true
    ) throws -> Self {
        let entity = try Self.fetchEntity(withId: id, in: context)
        entity.setValue(value, forKey: keyPath.propertyAsString)
        if save {
            try context.save()
        }
        return try Self(entity)
    }

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

    static func hasEntries(in context: NSManagedObjectContext) throws -> Bool {
        guard let request: NSFetchRequest<CoreDataEntity> = NSManagedObject.fetchRequest() as? NSFetchRequest<CoreDataEntity> else {
            throw CoreDataError.couldNotCastFetchRequest
        }
        request.entity = NSEntityDescription.entity(
            forEntityName: "\(CoreDataEntity.self)",
            in: context
        )
        request.fetchLimit = 1
        let entity: CoreDataEntity? = try context.fetch(request).first
        return entity != nil
    }

    static func count(in context: NSManagedObjectContext) throws -> Int {
        guard let request: NSFetchRequest<CoreDataEntity> = NSManagedObject.fetchRequest() as? NSFetchRequest<CoreDataEntity> else {
            throw CoreDataError.couldNotCastFetchRequest
        }
        request.entity = NSEntityDescription.entity(
            forEntityName: "\(CoreDataEntity.self)",
            in: context
        )
        return try context.count(for: request)
    }
}
