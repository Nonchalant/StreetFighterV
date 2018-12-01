protocol SelectionActionType {
    func setSelection(name key: String, index value: Int)
}

class SelectionAction: SelectionActionType {
    static let shared = SelectionAction()

    private let selectionStore: SelectionStoreType

    init(selectionStore: SelectionStoreType = SelectionStore.shared) {
        self.selectionStore = selectionStore
    }

    func setSelection(name key: String, index value: Int) {
        selectionStore.setSelection(key: key, value: value)
    }
}
