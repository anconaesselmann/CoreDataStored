//  Created by Axel Ancona Esselmann on 9/15/23.
//

import Foundation

public enum CoreDataError: Swift.Error {
    case couldNotLoadStore
    case couldNotCastFetchRequest
    case noManagedObjectContext
    case noResultReturned
    case missingProperty(String)
    case conflictingEntryWithId(UUID)
    case duplicateEntryWithId(UUID)
    case noElementWithId(UUID)
}
