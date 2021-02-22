import SpreadsheetView
import UIKit

class BlankCell: Cell {
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Color.Background.section
        gridlines = .all(.none)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension BlankCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
