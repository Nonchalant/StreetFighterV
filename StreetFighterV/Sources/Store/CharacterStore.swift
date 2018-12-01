protocol CharacterStoreType {
    var characters: [Character] { get }
    func set(characters: [Character])
}

class CharacterStore: CharacterStoreType {
    static let shared = CharacterStore()

    private(set) var characters: [Character] = []

    func set(characters: [Character]) {
        self.characters = characters
    }
}
