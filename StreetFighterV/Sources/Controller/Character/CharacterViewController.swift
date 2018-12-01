import NVActivityIndicatorView
import UIKit

class CharacterViewController: UIViewController, NVActivityIndicatorViewable {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let character = viewModel.characters[safe: indexPath.row] else {
            return
        }

        let viewController = FrameViewController(character: character)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
