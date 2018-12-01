import UIKit

protocol CharacterViewModelType {
    var characters: [Character] { get }
    func fetchCharacters(completion: @escaping () -> Void)
}

class CharacterViewModel: CharacterViewModelType {
    private let characterAction: CharacterActionType
    private let characterStore: CharacterStoreType

    init(characterAction: CharacterActionType = CharacterAction.shared,
         characterStore: CharacterStoreType = CharacterStore.shared) {
        self.characterAction = characterAction
        self.characterStore = characterStore
    }

    var characters: [Character] {
        return characterStore.characters
    }

    func fetchCharacters(completion: @escaping () -> Void) {
        characterAction.fetch(with: completion)
    }
}
