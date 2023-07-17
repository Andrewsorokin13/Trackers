import UIKit

protocol DelegateCollectionCellTextField: AnyObject {
    func sendText(string:String)
}

class EventCollectionView: UICollectionView {
    
    // MARK: - Init
    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    var collectionCellDelegate: DelegateCollectionCellTextField?
    var dataSourc: UICollectionViewDiffableDataSource<CollectionViewSection, String>!
    
    //MARK: - Set Collection view
    private func setupCollectionView() {
        register(CategoryCollectionCell.self, forCellWithReuseIdentifier: CategoryCollectionCell.reuseIdentifier)
        register(EmojiCollectionCell.self, forCellWithReuseIdentifier: EmojiCollectionCell.reuseIdentifier)
        register(ColorCollectionCell.self, forCellWithReuseIdentifier: ColorCollectionCell.reuseIdentifier)
        register(TextFieldCollectionViewCell.self, forCellWithReuseIdentifier: TextFieldCollectionViewCell.reuseIdentifier)
        register(SectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier)
        
        collectionViewLayout = createLayout()
        configureDataSource()
        configureHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSnapshot(_ model: EventSectionModel) {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionViewSection, String>()
        snapshot.appendSections(CollectionViewSection.allCases)
        snapshot.appendItems(model.textField, toSection: .textField)
        snapshot.appendItems(model.list, toSection: .list)
        snapshot.appendItems(model.emoji, toSection: .emoji)
        snapshot.appendItems(model.color, toSection: .color)
        
        dataSourc.apply(snapshot, animatingDifferences: true)
    }
    
    //MARK: - Private method
    private func configureDataSource() {
        dataSourc = UICollectionViewDiffableDataSource(collectionView: self, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let section = CollectionViewSection(rawValue: indexPath.section) else { fatalError("Unknown section") }
            switch section {
            case .textField :
                let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: TextFieldCollectionViewCell.reuseIdentifier, for: indexPath) as? TextFieldCollectionViewCell
                cell?.configurationCell()
                cell?.delegate = self
                return cell ?? UICollectionViewCell()
            case .list:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.reuseIdentifier, for: indexPath) as? CategoryCollectionCell
                cell?.configurationCell(text: "\(itemIdentifier)")
                return cell
            case .emoji:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCollectionCell.reuseIdentifier, for: indexPath) as? EmojiCollectionCell
                cell?.configurationCell(emoji: "\(itemIdentifier)")
                return cell
            case .color:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionCell.reuseIdentifier, for: indexPath) as? ColorCollectionCell
                cell?.configurationCell(color: "\(itemIdentifier)")
                return cell
            }
        })
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var heightSection = 0.0
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionLayoutKind = CollectionViewSection(rawValue: sectionIndex) else { return nil }
            let columns = sectionLayoutKind.columnCount
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 4, bottom: 1, trailing: 5)
            
            let groupHeight = columns == 1 ? NSCollectionLayoutDimension.absolute(75) : NSCollectionLayoutDimension.absolute(54)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 12, bottom: 20, trailing: 12)
            
            if sectionLayoutKind.nameSection == nil {
                heightSection = 0
            } else {
                heightSection = 50
            }
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(heightSection))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            _ = UICollectionViewCompositionalLayout(section: section)
            
            return section
            
        }
        return layout
    }
    
    private func configureHeader() {
        dataSourc.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            let sectionTitle = CollectionViewSection(rawValue: indexPath.section)?.nameSection
            let header = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier, for: indexPath) as! SectionHeaderReusableView
            header.titleLabel.text = sectionTitle
            return header
        }
    }
}

//MARK: - Conform SaveTextFieldDelegate
extension EventCollectionView: SaveTextFieldDelegate {
    func saveTextField(text: String) {
        collectionCellDelegate?.sendText(string: text)
    }
}
