//  Created by Axel Ancona Esselmann on 10/13/23.
//

import Foundation

extension KeyPath {
    var propertyAsString: String {
        NSExpression(forKeyPath: self).keyPath
    }
}
