import UIKit

class CharacterCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.textColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        alpha = highlighted ? 0.5 : 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        alpha = selected ? 0.5 : 1.0
    }
}

extension CharacterCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
