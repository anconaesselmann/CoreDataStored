//  Created by Axel Ancona Esselmann on 10/25/23.
//

import Foundation

public struct NotNil<T> {
    public let unwrapped: T
    public init(_ value: T?) throws {
        guard let unwrapped = value else {
            throw NoOptionalError.valueCanNotBeNil
        }
        self.unwrapped = unwrapped
    }
}
