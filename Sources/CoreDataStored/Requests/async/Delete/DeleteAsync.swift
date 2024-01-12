//  Created by Axel Ancona Esselmann on 1/11/24.
//

import Foundation
import CoreData

public extension CoreDataFetchable {
    @discardableResult
    static func delete(
        id: UUID,
        in context: NSManagedObjectContext,
        save: Bool = true
    ) async throws -> Self {
        try await context.perform {
            try delete(
               id: id,
               in: context,
               save: save
           )
        }
    }
}
