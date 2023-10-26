//  Created by Axel Ancona Esselmann on 9/15/23.
//

import Foundation

internal struct CoreDataAttribute {
    internal let name: String
    internal let value: CVarArg

    internal init(name: String, value: CVarArg) {
        self.name = name
        self.value = value
    }

    internal init<Entity, T>(keyPath: KeyPath<Entity, T>, value: CVarArg) {
        self.init(name: keyPath.propertyAsString, value: value)
    }

    internal static func name(_ name: String, value: CVarArg) -> Self {
        .init(name: name, value: value)
    }

    internal static func keyPath<Entity, T>(_ keyPath: KeyPath<Entity, T>, value: CVarArg) -> Self {
        .init(keyPath: keyPath, value: value)
    }
}
