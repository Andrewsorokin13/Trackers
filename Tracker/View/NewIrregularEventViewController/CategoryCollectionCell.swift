import UIKit

final class CategoryCollectionCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: CategoryCollectionCell.self)
    }
    
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
//        accessoryImageView.tintColor = UIColor.lightGray.withAlphaComponent(0.7)
        return image
    }()
    
     func configurationCell(text: String) {
        addUIElement()
        setConstraints()
         contentView.layer.cornerRadius = 8
         contentView.backgroundColor = .YPLightGray
        titleLabel.text = text
         
    }
}

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
            
            accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 13),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20),
            accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}


