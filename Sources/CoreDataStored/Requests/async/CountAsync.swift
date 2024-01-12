//  Created by Axel Ancona Esselmann on 10/25/23.
//

import Foundation
import CoreData

public extension CoreDataFetchable {
    static func count(in context: NSManagedObjectContext) async throws -> Int {
        try await context.perform {
            try count(in: context)
        }
    }

    static func hasEntries(in context: NSManagedObjectContext) async throws -> Bool {
        try await context.perform {
            try hasEntries(in: context)
        }
    }
}
