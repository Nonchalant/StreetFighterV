import UIKit

class CharacterCell: UITableViewCell {

}

extension CharacterCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
