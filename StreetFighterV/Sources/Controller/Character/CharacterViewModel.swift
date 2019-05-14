import UIKit

protocol CharacterViewModelType {
    var characters: [Character] { get }
    var seasons: [Season] { get }
    func fetchCharacters(completion: @escaping () -> Void)
}

class CharacterViewModel: CharacterViewModelType {
    private(set) var characters: [Character] = []
    private(set) var seasons: [Season] = []

    private let characterAction: CharacterActionType
    private let characterStore: CharacterStoreType

    init(characterAction: CharacterActionType = CharacterAction.shared,
         characterStore: CharacterStoreType = CharacterStore.shared) {
        self.characterAction = characterAction
        self.characterStore = characterStore
    }

    func fetchCharacters(completion: @escaping () -> Void) {
        characterAction.fetch { [weak self] in
            guard let me = self else {
                return
            }

            guard let seasons = Array(NSOrderedSet(array: me.characterStore.characters.map { $0.season })) as? [Season] else {
                Logger.error(L10n.shouldNeverReachHere)
                assertionFailure(L10n.shouldNeverReachHere)
                return
            }

            me.characters = me.characterStore.characters
            me.seasons = seasons
            completion()
        }
    }
}
