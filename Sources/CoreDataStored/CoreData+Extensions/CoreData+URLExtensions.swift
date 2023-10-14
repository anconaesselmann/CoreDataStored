//  Created by Axel Ancona Esselmann on 10/14/23.
//

import Foundation

public extension URL {
    init(enforceNotNil url: URL?) throws {
        guard let url = url else {
            throw NoOptionalError.valueCanNotBeNil
        }
        self = url
    }

    init(enforceNotNil urlString: String?) throws {
        guard let urlString = urlString else {
            throw NoOptionalError.valueCanNotBeNil
        }
        guard let url = URL(string: urlString) else {
            throw NoOptionalError.valueCanNotBeNil
        }
        self = url
    }
}
