import Foundation

struct Character: Codable {
    let name: String
    let sets: [Set]
}

extension Character {
    init(from dictionary: [String: Any]) throws {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let jsonDecoder = JSONDecoder()
        let character = try jsonDecoder.decode(Character.self, from: data)

        self = character
    }
}
