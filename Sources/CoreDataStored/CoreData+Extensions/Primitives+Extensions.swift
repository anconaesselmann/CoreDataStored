//  Created by Axel Ancona Esselmann on 10/25/23.
//

import Foundation

public extension Double {
    var nsDecimal: NSDecimalNumber {
        NSDecimalNumber(decimal: Decimal(self))
    }
}

public extension Int {
    var int8: Int8 {
        Int8(self)
    }

    var int16: Int16 {
        Int16(self)
    }

    var int32: Int32 {
        Int32(self)
    }

    var int64: Int64 {
        Int64(self)
    }
}

public extension Int8 {
    var int: Int {
        Int(self)
    }
}
public extension Int16 {
    var int: Int {
        Int(self)
    }
}

public extension Int32 {
    var int: Int {
        Int(self)
    }
}

public extension Int64 {
    var int: Int {
        Int(self)
    }
}
