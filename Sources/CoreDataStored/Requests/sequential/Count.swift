//  Created by Axel Ancona Esselmann on 1/11/24.
//

import Foundation
import CoreData

public extension CoreDataFetchable {
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
}
