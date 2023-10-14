//  Created by Axel Ancona Esselmann on 9/15/23.
//

import Foundation

public struct CoreDataAttribute {
    public let name: String
    public let value: CVarArg

    public init(name: String, value: CVarArg) {
        self.name = name
        self.value = value
    }

    public static func name(_ name: String, value: CVarArg) -> Self {
        .init(name: name, value: value)
    }
}
