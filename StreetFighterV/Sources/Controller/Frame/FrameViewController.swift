import SpreadsheetView
import UIKit

class FrameViewController: UIViewController {
    private lazy var spreadSheetView: SpreadsheetView = {
        let spreadSheetView = SpreadsheetView()
        spreadSheetView.translatesAutoresizingMaskIntoConstraints = false
        spreadSheetView.backgroundColor = Color.Background.section
        spreadSheetView.dataSource = dataSource
        spreadSheetView.delegate = self
        spreadSheetView.stickyRowHeader = true
        spreadSheetView.stickyColumnHeader = true
        spreadSheetView.register(BlankCell.self, forCellWithReuseIdentifier: BlankCell.reuseIdentifier)
        spreadSheetView.register(ChangeSetCell.self, forCellWithReuseIdentifier: ChangeSetCell.reuseIdentifier)
        spreadSheetView.register(FrameCell.self, forCellWithReuseIdentifier: FrameCell.reuseIdentifier)
        return spreadSheetView
    }()

    private lazy var dataSource = FrameViewDataSource(viewModel: viewModel)
    private let viewModel: FrameViewModelType

    init(character: Character) {
        self.viewModel = FrameViewModel(character: character)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItems()

        view.addSubview(spreadSheetView)
        [
            spreadSheetView.leftAnchor.constraint(equalTo: view.leftAnchor),
            spreadSheetView.topAnchor.constraint(equalTo: view.topAnchor),
            spreadSheetView.rightAnchor.constraint(equalTo: view.rightAnchor),
            spreadSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].setActive(true)
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        spreadSheetView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -view.safeAreaInsets.bottom, right: 0)
        spreadSheetView.invalidateIntrinsicContentSize()
    }

    private func setupNavigationItems() {
        navigationItem.title = viewModel.characterName
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Color.Text.title]
        navigationController?.navigationBar.tintColor = Color.Text.title
        navigationController?.navigationBar.barTintColor = Color.Background.theme
    }
}

extension FrameViewController: SpreadsheetViewDelegate {
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath == FrameViewModel.Const.changeSetIndexPath else {
            return
        }

        viewModel.changeSet {
            spreadsheetView.reloadData()
        }
    }
}

