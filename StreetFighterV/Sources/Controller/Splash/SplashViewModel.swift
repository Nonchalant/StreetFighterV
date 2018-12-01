protocol SplashViewModelType {
    func signIn(completion: @escaping () -> Void)
}

class SplashViewModel: SplashViewModelType {
    static let shared = SplashViewModel()

    private let firebaseAction: FirebaseActionType

    init(firebaseAction: FirebaseActionType = FirebaseAction.shared) {
        self.firebaseAction = firebaseAction
    }

    func signIn(completion: @escaping () -> Void) {
        firebaseAction.signIn(with: completion)
    }
}
