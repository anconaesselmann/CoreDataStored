//  Created by Axel Ancona Esselmann on 10/25/23.
//

import Foundation

public extension CoreDataFetchable {
    typealias KP<T> = KeyPath<CoreDataEntity, T>
    typealias Attribute<T> = (keyPath: KP<T>, value: CVarArg)
}
