//  Created by Axel Ancona Esselmann on 9/15/23.
//

import Foundation

public protocol CoreDataIdentifiable: AnyObject {
    var id: UUID? { get set}
}
