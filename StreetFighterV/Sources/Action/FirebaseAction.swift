import Firebase

protocol FirebaseActionType {
    func setup()
    func signIn(with completion: @escaping (() -> Void))
    func fetch(with completion: @escaping (([[String: Any]]) -> Void))
}

class FirebaseAction: FirebaseActionType {
    static let shared = FirebaseAction()

    private var firestore: Firestore?

    func setup() {
        FirebaseApp.configure()
        Fabric.with([Crashlytics.self])

        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        settings.areTimestampsInSnapshotsEnabled = true

        let db = Firestore.firestore()
        db.settings = settings

        self.firestore = db
    }

    func signIn(with completion: @escaping (() -> Void)) {
        Auth.auth().signInAnonymously { (result, error) in
            if let error = error {
                Logger.error(error.localizedDescription)
                assertionFailure(error.localizedDescription)
                return
            }

            guard result != nil else {
                let localizedDescription = "Not Found Auth"
                Logger.error(localizedDescription)
                assertionFailure(localizedDescription)
                return
            }

            completion()
        }
    }

    func fetch(with completion: @escaping (([[String: Any]]) -> Void)) {
        firestore?.collection(Const.collection + " (\(getLanguageCode()))").getDocuments { (querySnapshot, error) in
            if let error = error {
                Logger.error(error.localizedDescription)
                assertionFailure(error.localizedDescription)
                return
            }

            guard let querySnapshot = querySnapshot else {
                let localizedDescription = "Not Found QuerySnapshot"
                Logger.error(localizedDescription)
                assertionFailure(localizedDescription)
                return
            }

            completion(querySnapshot.documents.map({ $0.data() }))
        }
    }

    private func getLanguageCode() -> LanguageCode {
        guard let languageCode = Locale.current.languageCode else {
            return .en
        }

        return LanguageCode(rawValue: languageCode)
    }
}

extension FirebaseAction {
    private enum Const {
        static let collection = "Characters"
    }
}
