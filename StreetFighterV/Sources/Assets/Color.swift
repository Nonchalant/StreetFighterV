import UIKit

enum Color {
    enum Background {
        static let theme = UIColor(hex: 0x19448e)

        static let section  = UIColor(hex: 0x317CC8)
        static let normal  = UIColor(hex: 0xFFFFFF)
        static let reverse = UIColor(hex: 0xF4F4FA)
    }

    enum Separator {
        static let normal = UIColor(hex: 0x317CC8)
    }

    enum Text {
        static let changeSet = UIColor(hex: 0xD71417)
        static let title     = UIColor(hex: 0xFFFFFF)

        static let normal    = UIColor(hex: 0x000000)
        static let positive  = UIColor(hex: 0x008000)
        static let negative  = UIColor(hex: 0xCC0000)
    }
}
