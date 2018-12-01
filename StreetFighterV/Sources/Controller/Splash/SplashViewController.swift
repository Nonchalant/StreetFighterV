import UIKit

class SplashViewController: UIViewController {
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Asset.pad.image
        imageView.widthAnchor.constraint(equalToConstant: Const.iconWidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Const.iconHeight).isActive = true
        return imageView
    }()

    private let viewModel: SplashViewModelType = SplashViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.Background.theme

        self.view.addSubview(icon)
        [
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ].setActive(true)

        viewModel.signIn {
            let viewController = CharacterViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            UIApplication.shared.keyWindow?.rootViewController = navigationController
        }
    }
}

extension SplashViewController {
    private enum Const {
        static let iconWidth: CGFloat = 100
        static let iconHeight: CGFloat = 100
    }
}
