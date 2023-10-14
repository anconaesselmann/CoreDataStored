//  Created by Axel Ancona Esselmann on 9/15/23.
//

import Foundation

public extension UUID {
    init(enforceNotNil uuid: UUID?) throws {
        guard let uuid = uuid else {
            throw NoOptionalError.valueCanNotBeNil
        }
        self = uuid
    }
}
