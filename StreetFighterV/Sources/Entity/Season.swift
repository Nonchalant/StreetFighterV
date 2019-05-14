enum Season: Decodable, Hashable {
    case original
    case season(number: Int)
}

extension Season {
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(Int.self)

        switch value {
        case 0:
            self = .original
        default:
            self = .season(number: value)
        }
    }
}

extension Season {
    var title: String {
        switch self {
        case .original:
            return L10n.original
        case let .season(number):
            return "\(L10n.season) \(number)"
        }
    }
}
