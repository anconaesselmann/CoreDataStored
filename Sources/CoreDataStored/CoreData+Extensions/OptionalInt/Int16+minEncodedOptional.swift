//  Created by Axel Ancona Esselmann on 2/25/24.
//

import Foundation

public extension Int16 {

    enum Error: Swift.Error {
        case underflow
        case overflow
    }

    init(minEncodedOptional value: Int?) throws {
        guard let value = value else {
            self = .min
            return
        }
        guard value > Int(Self.min) else {
            throw Error.underflow
        }
        guard value <= Int(Self.max) else {
            throw Error.overflow
        }
        self = Int16(value)
    }

    var minEncodedOptional: Int? {
        guard self != Self.min else {
            return nil
        }
        return Int(self)
    }
}
