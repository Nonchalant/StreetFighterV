import SpreadsheetView
import UIKit

class FrameCell: Cell {
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(textLabel)

        [
            textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Const.margin),
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Const.margin),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].setActive(true)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        textLabel.text = ""
        gridlines = .all(.solid(width: 1.0, color: Color.Separator.normal))
    }

    func setBackground(with backgroundColor: UIColor) {
        contentView.backgroundColor = backgroundColor
        gridlines = .all(.solid(width: 1.0, color: Color.Separator.normal))
    }
}

extension FrameCell {
    private enum Const {
        static let margin: CGFloat = 2.0
        static let separator: CGFloat = 1.0
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
