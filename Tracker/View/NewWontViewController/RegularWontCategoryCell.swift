import UIKit

final class RegularWontCategoryCell: UITableViewCell {
    
    //MARK: - Static id
    static var reuseIdentifier: String {
        return String(describing: CategoryCollectionCell.self)
    }
    
    //MARK: - UI elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.sfProMedium(size: 16)
        label.textColor = .YPBlackDay
        return label
    }()
    
    private lazy var detailLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.sfProRegular(size: 17)
        label.textColor = .YPGray
        return label
    }()
    
    private lazy var accessoryImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName:  "chevron.right")
        image.tintColor = UIColor.lightGray.withAlphaComponent(0.7)
        return image
    }()
    
    //MARK: - Internal func Configuration Cell
    func configurationCell(text: String?, detail: String?) {
        addUIElement()
        setConstraints()

        contentView.backgroundColor = .YPLightGray
        guard let text = text else { return }
        titleLabel.text = text
        guard let detail = detail else { return  }
        detailLable.text = detail
         
    }
}

//MARK: - Set ui elements
private extension RegularWontCategoryCell {
    private func addUIElement() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLable)
        contentView.addSubview(accessoryImageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            //
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            //
            detailLable.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            //
            accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 13),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 20),
            accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}
