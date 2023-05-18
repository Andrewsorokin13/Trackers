import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: CategoryTableViewCell.self)
    }
    
    private lazy var categoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    private var isCheckmark = false

    func config(label: String) {
        addUIElements()
        setConstraint()
        categoryName.text = label
    }
}

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
