import UIKit

class CharacterViewDataSource: NSObject, UITableViewDataSource {
    private let viewModel: CharacterViewModelType

    init(viewModel: CharacterViewModelType) {
        self.viewModel = viewModel
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let season = viewModel.seasons[safe: section] else {
            return 0
        }

        return viewModel.characters
            .filter { $0.season == season }
            .count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.seasons.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.seasons[safe: section]?.title ?? nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseIdentifier, for: indexPath) as! CharacterCell

        guard let season = viewModel.seasons[safe: indexPath.section],
            let character = viewModel.characters.filter({ $0.season == season })[safe: indexPath.row] else {
            Logger.error(L10n.shouldNeverReachHere)
            assertionFailure(L10n.shouldNeverReachHere)
            return cell
        }

        cell.textLabel?.text = character.name
        cell.backgroundColor = (indexPath.row % 2 == 0) ? Color.Background.normal : Color.Background.reverse
        return cell
    }
}
