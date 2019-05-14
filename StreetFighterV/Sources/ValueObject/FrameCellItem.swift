import UIKit

enum FrameCellItem {
    case section(title: String)
    case name(title: String)
    case startUp(title: String)
    case active(title: String)
    case recovery(title: String)
    case recoveryOnHit(title: String, textColor: UIColor)
    case recoveryOnBlock(title: String, textColor: UIColor)
    case vTriggerCancelRecoveryOnHit(title: String, textColor: UIColor)
    case vTriggerCancelRecoveryOnBlock(title: String, textColor: UIColor)
    case comments(title: String)

    var text: String {
        switch self {
        case let .section(title):
            return title

        case let .name(title),
             let .startUp(title),
             let .active(title),
             let .recovery(title),
             let .recoveryOnHit(title, _),
             let .recoveryOnBlock(title, _),
             let .vTriggerCancelRecoveryOnHit(title, _),
             let .vTriggerCancelRecoveryOnBlock(title, _),
             let .comments(title):
            return title.isEmpty ? L10n.empty : title
        }
    }

    var textColor: UIColor {
        switch self {
        case .section:
            return Color.Text.title

        case .name,
             .startUp,
             .active,
             .recovery,
             .comments:
            return Color.Text.normal

        case let .recoveryOnHit(_, textColor),
             let .recoveryOnBlock(_, textColor),
             let .vTriggerCancelRecoveryOnHit(_, textColor),
             let .vTriggerCancelRecoveryOnBlock(_, textColor):
            return textColor
        }
    }

    var font: UIFont {
        switch self {
        case .section:
            return UIFont.boldSystemFont(ofSize: Const.textSize)

        case .name,
             .startUp,
             .active,
             .recovery,
             .recoveryOnHit,
             .recoveryOnBlock,
             .vTriggerCancelRecoveryOnHit,
             .vTriggerCancelRecoveryOnBlock:
            return UIFont.systemFont(ofSize: Const.textSize)

        case .comments:
            return UIFont.systemFont(ofSize: Const.textSizeForComments)
        }
    }

    var width: CGFloat {
        switch self {
        case .name:
            return Const.widthForNameColumn

        case .startUp,
             .active,
             .recovery,
             .recoveryOnHit,
             .recoveryOnBlock,
             .vTriggerCancelRecoveryOnHit,
             .vTriggerCancelRecoveryOnBlock:
            return Const.widthForElementColumn

        case .comments:
            return Const.widthForCommentColumn

        case .section:
            let localizedDescription = "Never Reach Here"
            Logger.error(localizedDescription)
            assertionFailure(localizedDescription)
            return Const.widthForElementColumn
        }
    }

    var isSection: Bool {
        switch self {
        case .section:
            return true
        default:
            return false
        }
    }
}

extension FrameCellItem {
    private enum Const {
        static let textSize: CGFloat = 14
        static let textSizeForComments: CGFloat = 12

        static let widthForNameColumn: CGFloat = 110
        static let widthForElementColumn: CGFloat = 52
        static let widthForCommentColumn: CGFloat = 200
    }
}

extension FrameCellItem {
    static let titles: [FrameCellItem] = [
        .name,
        .startUp,
        .active,
        .recovery,
        .recoveryOnHit,
        .recoveryOnBlock,
        .vTriggerCancelRecoveryOnHit,
        .vTriggerCancelRecoveryOnBlock,
        .comments
    ]

    private static let name = FrameCellItem.name(title: L10n.moveName)
    private static let startUp = FrameCellItem.startUp(title: L10n.moveStartUp)
    private static let active = FrameCellItem.active(title: L10n.moveActive)
    private static let recovery = FrameCellItem.recovery(title: L10n.moveRecovery)
    private static let recoveryOnHit = FrameCellItem.recoveryOnHit(title: L10n.moveRecoveryOnHit,
                                                                   textColor: Color.Text.normal)
    private static let recoveryOnBlock = FrameCellItem.recoveryOnBlock(title: L10n.moveRecoveryOnBlock,
                                                                       textColor: Color.Text.normal)
    private static let vTriggerCancelRecoveryOnHit = FrameCellItem.vTriggerCancelRecoveryOnHit(title: L10n.moveVTriggerCancelRecoveryOnHit,
                                                                                               textColor: Color.Text.normal)
    private static let vTriggerCancelRecoveryOnBlock = FrameCellItem.vTriggerCancelRecoveryOnBlock(title: L10n.moveVTriggerCancelRecoveryOnBlock,
                                                                                                   textColor: Color.Text.normal)
    private static let comments = FrameCellItem.comments(title: L10n.moveComments)
}
