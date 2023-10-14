//  Created by Axel Ancona Esselmann on 9/15/23.
//

import Foundation
import CoreData

public extension NSManagedObject {
    func currentContext() throws -> NSManagedObjectContext {
        guard let context = managedObjectContext else {
            throw CoreDataError.noManagedObjectContext
        }
        return context
    }
}
