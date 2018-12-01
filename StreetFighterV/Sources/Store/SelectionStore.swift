import Foundation

protocol SelectionStoreType {
    func getSelection(key: String) -> Int
    func setSelection(key: String, value: Int)
}

class SelectionStore: SelectionStoreType {
    static let shared = SelectionStore()

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func getSelection(key: String) -> Int {
        return (userDefaults.value(forKey: key) as? Int) ?? 0
    }

    func setSelection(key: String, value: Int) {
        userDefaults.set(value, forKey: key)
    }
}
