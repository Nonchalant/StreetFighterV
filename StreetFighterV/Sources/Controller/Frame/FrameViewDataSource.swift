import SpreadsheetView
import Crashlytics

class FrameViewDataSource: SpreadsheetViewDataSource {
    private let viewModel: FrameViewModelType

    init(viewModel: FrameViewModelType) {
        self.viewModel = viewModel
    }

    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return viewModel.items.first?.count ?? 0
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return viewModel.items.count
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return (column == 0) ? Const.widthForTitleColumn : Const.widthForElementColumn
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return Const.heightForRow
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        if indexPath == FrameViewModel.Const.changeSetIndexPath {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: ChangeSetCell.reuseIdentifier, for: indexPath) as! ChangeSetCell
            cell.textLabel.text = viewModel.currentSetName
            return cell
        } else {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: FrameCell.reuseIdentifier, for: indexPath) as! FrameCell

            if let head = viewModel.items[safe: indexPath.row]?.first {
                switch head {
                case .section:
                    cell.setBackground(with: Color.Background.section)
                case .move:
                    cell.setBackground(with: (indexPath.row % 2 == 0) ? Color.Background.normal : Color.Background.reverse)
                }
            }

            // Gridlines
            do {
                if indexPath.column == 0 {
                    cell.gridlines.right = .solid(width: Const.separator, color: Color.Separator.normal)
                }

                if let previous = viewModel.items[safe: indexPath.row - 1]?.first, previous.isSection {
                    cell.gridlines.top = .none
                }

                if indexPath.row == 0 {
                    cell.gridlines.bottom = .solid(width: Const.separator, color: Color.Separator.normal)
                } else if let next = viewModel.items[safe: indexPath.row + 1]?.first, next.isSection {
                    cell.gridlines.bottom = .none
                }
            }

            if let item = viewModel.items[safe: indexPath.row]?[safe: indexPath.column] {
                cell.textLabel.text = item.title
                cell.textLabel.textColor = item.textColor
                cell.textLabel.font = item.isSection ? UIFont.boldSystemFont(ofSize: Const.textSize) : UIFont.systemFont(ofSize: Const.textSize)
            }

            return cell
        }
    }

    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return viewModel.items.isEmpty ? 0 : 1
    }

    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return viewModel.items.isEmpty ? 0 : 1
    }
}

extension FrameViewDataSource {
    private enum Const {
        static let widthForTitleColumn: CGFloat = 110
        static let widthForElementColumn: CGFloat = 52
        static let heightForRow: CGFloat = 40

        static let textSize: CGFloat = 14
        static let separator: CGFloat = 5.0
    }
}
