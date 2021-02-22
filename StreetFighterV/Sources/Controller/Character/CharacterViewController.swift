import NVActivityIndicatorView
import UIKit

class CharacterViewController: UIViewController, NVActivityIndicatorViewable {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Color.Background.section
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseIdentifier)
        return tableView
    }()

    private lazy var dataSource = CharacterViewDataSource(viewModel: viewModel)
    private let viewModel: CharacterViewModelType = CharacterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        startAnimating(type: .ballScale)

        setupNavigationItems()

        view.addSubview(tableView)
        [
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].setActive(true)

        viewModel.fetchCharacters { [weak self] in
            self?.stopAnimating()
            self?.tableView.reloadData()
        }
    }

    private func setupNavigationItems() {
        navigationItem.title = L10n.character
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Color.Text.title]
        navigationController?.navigationBar.barTintColor = Color.Background.theme
    }
}

extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = Color.Background.section
        guard let header = view as? UITableViewHeaderFooterView else {
            Logger.error(L10n.shouldNeverReachHere)
            assertionFailure(L10n.shouldNeverReachHere)
            return
        }
        header.textLabel?.textColor = Color.Text.title
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let season = viewModel.seasons[safe: indexPath.section],
            let character = viewModel.characters.filter({ $0.season == season })[safe: indexPath.row] else {
            return
        }

        let viewController = FrameViewController(character: character)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
