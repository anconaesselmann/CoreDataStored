//  Created by Axel Ancona Esselmann on 2/29/24.
//

import Foundation

public extension Int32 {

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
        self = Int32(value)
    }

    var minEncodedOptional: Int? {
        guard self != Self.min else {
            return nil
        }
        return Int(self)
    }
}
