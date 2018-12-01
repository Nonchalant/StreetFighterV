import UIKit

extension Sequence where Element == NSLayoutConstraint {
    func setActive(_ isActive: Bool) {
        self.forEach { constraint in
            constraint.isActive = isActive
        }
    }
}
