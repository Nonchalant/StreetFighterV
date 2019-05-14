enum LanguageCode: String {
    case en
    case ja
}

extension LanguageCode {
    init(rawValue: String) {
        switch rawValue {
        case LanguageCode.en.rawValue:
            self = .en
        case LanguageCode.ja.rawValue:
            self = .ja
        default:
            self = .en
        }
    }
}
