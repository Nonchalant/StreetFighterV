import UIKit

enum FrameCellItem {
    case section(title: String)
    case move(title: String, textColor: UIColor)

    var title: String {
        switch self {
        case let .section(title):
            return title
        case let .move(title, _):
            return title.isEmpty ? L10n.empty : title
        }
    }

    var textColor: UIColor {
        switch self {
        case .section:
            return Color.Text.title
        case let .move(_, textColor):
            return textColor
        }
    }

    var isSection: Bool {
        switch self {
        case .section:
            return true
        case .move:
            return false
        }
    }
}

extension FrameCellItem {
    static func move(title: String) -> FrameCellItem {
        return FrameCellItem.move(title: title, textColor: Color.Text.normal)
    }

    static let name = FrameCellItem.move(title: L10n.moveName)
    static let startUp = FrameCellItem.move(title: L10n.moveStartUp)
    static let active = FrameCellItem.move(title: L10n.moveActive)
    static let recovery = FrameCellItem.move(title: L10n.moveRecovery)
    static let recoveryOnHit = FrameCellItem.move(title: L10n.moveRecoveryOnHit)
    static let recoveryOnBlock = FrameCellItem.move(title: L10n.moveRecoveryOnBlock)
    static let vTriggerCancelRecoveryOnHit = FrameCellItem.move(title: L10n.moveVTriggerCancelRecoveryOnHit)
    static let vTriggerCancelRecoveryOnBlock = FrameCellItem.move(title: L10n.moveVTriggerCancelRecoveryOnBlock)
}
