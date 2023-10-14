//  Created by Axel Ancona Esselmann on 9/15/23.
//

import Foundation

public extension String {
    init(enforceNotNil string: String?) throws {
        guard let string = string else {
            throw NoOptionalError.valueCanNotBeNil
        }
        self = string
    }
}
