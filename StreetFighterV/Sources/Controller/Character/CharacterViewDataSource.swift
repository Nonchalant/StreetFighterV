import UIKit

class CharacterViewDataSource: NSObject, UITableViewDataSource {
    private let viewModel: CharacterViewModelType

    init(viewModel: CharacterViewModelType) {
        self.viewModel = viewModel
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseIdentifier, for: indexPath) as! CharacterCell
        cell.textLabel?.text = viewModel.characters[safe: indexPath.row]?.name
        cell.backgroundColor = (indexPath.row % 2 == 0) ? Color.Background.normal : Color.Background.reverse
        return cell
    }
}
