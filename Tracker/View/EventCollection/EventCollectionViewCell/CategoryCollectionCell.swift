import UIKit

final class CategoryCollectionCell: UICollectionViewCell {
    
    //MARK: - Static Identifier
    static var reuseIdentifier: String {
        return String(describing: CategoryCollectionCell.self)
    }
    
    //MARK: - UI element
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .YPBlackDay
        return label
    }()
    
    private lazy var detailLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .YPBlackDay
        return label
    }()
    
    private lazy var accessoryImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName:  "chevron.right")
        image.tintColor = .YPGray
        return image
    }()
    
    //MARK: - Configuration cell
    func configurationCell(text: String) {
        addUIElement()
        setConstraints()
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .YPBackgroundDay
        titleLabel.text = text
    }
}

//MARK: - Conform protocol
extension CategoryCollectionCell: AddCategoryToEventDelegate {
    
    func setCategory(name: String) {
        detailLable.text = name
    }
}

//MARK: - Add UI element
private extension CategoryCollectionCell {
    private func addUIElement() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLable)
        contentView.addSubview(accessoryImageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            //
            detailLable.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailLable.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            detailLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            //
            accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 13),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20),
            accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}
