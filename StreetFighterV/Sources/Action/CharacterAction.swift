protocol CharacterActionType {
    func fetch(with completion: @escaping (() -> Void))
}

class CharacterAction: CharacterActionType {
    static let shared = CharacterAction()

    private let firebaseAction: FirebaseActionType
    private let characterStore: CharacterStoreType

    init(firebaseAction: FirebaseActionType = FirebaseAction.shared,
         characterStore: CharacterStoreType = CharacterStore.shared) {
        self.firebaseAction = firebaseAction
        self.characterStore = characterStore
    }

    func fetch(with completion: @escaping (() -> Void)) {
        firebaseAction.fetch { [weak self] array in
            guard let me = self else {
                return
            }

            let characters = array
                .compactMap { dictionary -> Character? in
                    do {
                        return try Character(from: dictionary)
                    } catch {
                        Logger.error(error.localizedDescription)
                        assertionFailure(error.localizedDescription)
                        return nil
                    }
                }
                .sorted(by: { (pre, next) -> Bool in
                    pre.sequenceId < next.sequenceId
                })

            me.characterStore.set(characters: characters)
            completion()
        }
    }
}
