import Foundation

struct Character: Decodable {
    let name: String
    let sequenceId: Int
    let season: Season
    let sets: [MoveSet]
}

extension Character {
    init(from dictionary: [String: Any]) throws {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let jsonDecoder = JSONDecoder()
        let character = try jsonDecoder.decode(Character.self, from: data)

        self = character
    }
}
