import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    //MARK: - Static id
    static var reuseIdentifier: String {
        return String(describing: CategoryTableViewCell.self)
    }
    
    //MARK: - UI elements
    private lazy var categoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Internal func Configuration Cell
    func configure(with title: String) {
        addUIElements()
        setConstraint()
        categoryName.text = title
    }
}

//MARK: - Set UI elements
extension CategoryTableViewCell {
    private func addUIElements() {
        contentView.addSubview(categoryName)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            categoryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryName.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
}
