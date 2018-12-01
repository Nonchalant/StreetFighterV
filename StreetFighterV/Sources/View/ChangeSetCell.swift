import SpreadsheetView
import UIKit

class ChangeSetCell: Cell {
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = Color.Text.changeSet
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: Const.textSize)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let iconLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.Text.changeSet
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: Const.iconSize)
        label.text = L10n.selection
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        gridlines.right = .solid(width: Const.separator, color: Color.Separator.normal)
        gridlines.bottom = .solid(width: Const.separator, color: Color.Separator.normal)

        contentView.addSubview(textLabel)
        [
            textLabel.leftAnchor.constraint(greaterThanOrEqualTo: contentView.leftAnchor, constant: Const.margin),
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ].setActive(true)

        contentView.addSubview(iconLabel)
        [
            iconLabel.leftAnchor.constraint(equalTo: textLabel.rightAnchor, constant: Const.spacing),
            iconLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconLabel.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -Const.margin),
            iconLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].setActive(true)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension ChangeSetCell {
    private enum Const {
        static let margin: CGFloat = 2.0
        static let spacing: CGFloat = 4.0

        static let textSize: CGFloat = 16.0
        static let iconSize: CGFloat = 14.0
        static let separator: CGFloat = 5.0
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

