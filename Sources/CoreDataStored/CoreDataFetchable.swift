//  Created by Axel Ancona Esselmann on 9/15/23.
//

import Foundation
import CoreData

public protocol CoreDataFetchable {
    associatedtype CoreDataEntity
        where CoreDataEntity: NSManagedObject

    init(_ entity: CoreDataEntity) throws
}
