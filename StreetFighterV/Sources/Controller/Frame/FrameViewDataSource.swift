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
        return viewModel.items.count + 1
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return FrameCellItem.titles[safe: column]?.width ?? 0
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return row == viewModel.items.count
            ? spreadsheetView.safeAreaInsets.bottom
            : Const.heightForRow
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        guard indexPath != FrameViewModel.Const.changeSetIndexPath else {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: ChangeSetCell.reuseIdentifier, for: indexPath) as! ChangeSetCell
            cell.textLabel.text = viewModel.currentSetName
            return cell
        }

        switch indexPath.row {
        case viewModel.items.count:
            return spreadsheetView.dequeueReusableCell(withReuseIdentifier: BlankCell.reuseIdentifier, for: indexPath) as! BlankCell

        default:
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: FrameCell.reuseIdentifier, for: indexPath) as! FrameCell

            // BackgroundColor
            do {
                if case .section = viewModel.items[safe: indexPath.row]?.first {
                    cell.setBackground(with: Color.Background.section)
                } else {
                    cell.setBackground(with: (indexPath.row % 2 == 0) ? Color.Background.normal : Color.Background.reverse)
                }
            }

            if let item = viewModel.items[safe: indexPath.row]?[safe: indexPath.column] {
                cell.textLabel.text = item.text
                cell.textLabel.textColor = item.textColor
                cell.textLabel.font = item.font
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
        static let heightForRow: CGFloat = 40
        static let separator: CGFloat = 5.0
    }
}
