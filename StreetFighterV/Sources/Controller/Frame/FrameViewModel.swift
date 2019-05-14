import UIKit

protocol FrameViewModelType {
    var characterName: String { get }
    var currentSetName: String { get }
    var items: [[FrameCellItem]] { get }
    func changeSet(completion: () -> Void)
}

class FrameViewModel: FrameViewModelType {
    private(set) var items: [[FrameCellItem]] = []

    private let character: Character
    private let selectionAction: SelectionActionType
    private let selectionStore: SelectionStoreType

    private var setIndex: Int {
        didSet {
            selectionAction.setSelection(name: characterName, index: setIndex)
        }
    }

    init(character: Character,
         selectionAction: SelectionActionType = SelectionAction.shared,
         selectionStore: SelectionStoreType = SelectionStore.shared) {
        self.character = character
        self.selectionAction = selectionAction
        self.selectionStore = selectionStore

        self.setIndex = selectionStore.getSelection(key: character.name)

        reloadItems()
    }

    var characterName: String {
        return character.name
    }

    var currentSetName: String {
        return character.sets[safe: setIndex]?.name ?? ""
    }

    func changeSet(completion: () -> Void) {
        self.setIndex = (setIndex + 1) % character.sets.count
        reloadItems()

        completion()
    }

    private func reloadItems() {
        guard let set = character.sets[safe: setIndex] else {
            return
        }

        var items: [[FrameCellItem]] = [FrameCellItem.titles]

        [
            (L10n.normalMoves, set.normalMoves),
            (L10n.uniqueAttacks, set.uniqueAttacks),
            (L10n.normalThrows, set.normalThrows),
            (L10n.vSystem, set.vSystem),
            (L10n.specialMoves, set.specialMoves),
            (L10n.criticalArts, set.criticalArts)
        ].forEach { (title, moves) in
            guard let moves = moves, !moves.isEmpty else {
                return
            }

            items.append([FrameCellItem.section(title: title)])
            moves.forEach { items.append(subItems(with: $0)) }
        }

        self.items = items
    }

    private func subItems(with move: Move) -> [FrameCellItem] {
        return [
            FrameCellItem.name(title: move.name),
            FrameCellItem.startUp(title: move.startUp),
            FrameCellItem.active(title: move.active),
            FrameCellItem.recovery(title: move.recovery),
            FrameCellItem.recoveryOnHit(title: move.recoveryOnHit, textColor: textColor(with: move.recoveryOnHit)),
            FrameCellItem.recoveryOnBlock(title: move.recoveryOnBlock, textColor: textColor(with: move.recoveryOnBlock)),
            FrameCellItem.vTriggerCancelRecoveryOnHit(title: move.vTriggerCancelRecoveryOnHit, textColor: textColor(with: move.vTriggerCancelRecoveryOnHit)),
            FrameCellItem.vTriggerCancelRecoveryOnBlock(title: move.vTriggerCancelRecoveryOnBlock, textColor: textColor(with: move.vTriggerCancelRecoveryOnBlock)),
            FrameCellItem.comments(title: move.comments)
        ]
    }

    private func textColor(with frame: String) -> UIColor {
        switch Int(frame) ?? 0 {
        case 1...:
            return Color.Text.positive
        case 0:
            return Color.Text.normal
        case ...(-1):
            return Color.Text.negative
        default:
            return Color.Text.normal
        }
    }
}

extension FrameViewModel {
    enum Const {
        static let changeSetIndexPath = IndexPath(row: 0, column: 0)
    }
}
