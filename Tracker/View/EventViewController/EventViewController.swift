import UIKit

protocol AddCategoryToEventDelegate {
    func setCategory(name: String)
}

final class EventViewController: UIViewController {
    
    //MARK: - UI elements
    private let horizontalStackBottomButton: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var createButton: UIButton = {
        UIButton.customButton(
            "Создать",
            borderColor: nil,
            titleColor: UIColor.YPWhiteDay,
            selector: #selector(saveNewRegularWont),
            target: self,
            cornerRadius: 16,
            borderWidth: nil,
            backgroundColor: UIColor.YPGray)
    }()
    
    private lazy var cancelButton: UIButton = {
        UIButton.customButton(
            "Отменить",
            borderColor: UIColor.YPRed,
            titleColor: UIColor.YPRed,
            selector: #selector(cancelsaveNewRegularWont),
            target: self,
            cornerRadius: 15,
            borderWidth: 1,
            backgroundColor: nil)
    }()
    
    private lazy var collectionView: EventCollectionView = {
        let collection = EventCollectionView(frame: .zero)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.collectionCellDelegate = self
        return collection
    }()
    
    //MARK: - Private property
    private var viewModel: EventViewModel?
    
    //MARK: Delegate
    private var collectionDelegate: EventCollectionViewDelegate?

    //MARK: - Set ViewModel
    func setViewModel(viewModel: EventViewModel, title: String) {
        self.viewModel = viewModel
        navigationItem.title = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUIElements()
        setConstraint()
        setCollectionView()
    }
    
    //MARK: - Action button
    @objc
    private func cancelsaveNewRegularWont() {
        dismiss(animated: true)
    }
    
    @objc
    private func saveNewRegularWont() {
        viewModel?.saveEvent()
        dismiss(animated: false)
    }
}

extension EventViewController: DelegateCollectionCellTextField {
    func sendText(string: String) {
        guard let viewModel = viewModel else { return }
        viewModel.saveText(text: string)
    }
}

//MARK: - Conform SaveScheduleListDelegate
extension EventViewController: SaveScheduleListDelegate {
    func saveSchedule(category: [Weekday]) {
        viewModel?.addSchedule(day: category)
        collectionView.reloadData()
    }
}

//MARK: - Conform TableViewCategoryDelegate
extension EventViewController: TableViewCategoryDelegate {
    func selectedCategory(name: String) {
        viewModel?.saveCategory(text: name)
    }
}

//MARK: - Conform SaveEventCollectionViewDelegate
extension EventViewController: SaveEventCollectionViewDelegate {
    func saveEmoje(indexPath: IndexPath) {
        viewModel?.getElement(indexPath: indexPath)
    }
    
    func saveColor(indexPath: IndexPath) {
        viewModel?.saveColor(indexPath: indexPath)
    }
    
    func didSelectItem(_ item: IndexPath) {
        switch item.row {
        case 0 :
            let vc = CategoryTableViewController()
            vc.delegate = self
            present(vc, animated: true)
        default:
            let vc = ScheduleViewController()
            vc.delegate = self
            present(vc, animated: true)
        }
    }
}


//MARK: - Set UI elements
private extension EventViewController {
    private func setCollectionView() {
        collectionDelegate = EventCollectionViewDelegate()
        collectionDelegate?.delegate = self
        collectionView.delegate = collectionDelegate
        guard let model = viewModel?.getCollectionViewSnapshot() else { return }
        collectionView.updateSnapshot(model)
    }
    
    private func addUIElements() {
        view.addSubview(collectionView)
        view.addSubview(horizontalStackBottomButton)
        view.backgroundColor = .YPWhiteDay
        //
        horizontalStackBottomButton.addArrangedSubview(cancelButton)
        horizontalStackBottomButton.addArrangedSubview(createButton)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            //CollectionView
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: horizontalStackBottomButton.topAnchor),
            //HorizontalStackBottomButton
            horizontalStackBottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            horizontalStackBottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            horizontalStackBottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            horizontalStackBottomButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
}
