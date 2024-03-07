//  Created by Axel Ancona Esselmann on 3/6/24.
//

import Foundation

public extension Int {

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
        self = Int(value)
    }

    var minEncodedOptional: Int? {
        guard self != Self.min else {
            return nil
        }
        return Int(self)
    }
}
