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
    
    private lazy var checkmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapbutton), for: .touchUpInside)
        return button
    }()

    func config(label: String, isCheckmark: Bool) {
        addUIElements()
        setConstraint()
        categoryName.text = label
        let image =  UIImage(named: "checkmark")
        checkmarkButton.setImage(image, for: .normal)
    }
    
    @objc
    private func tapbutton() {
        //
    }

}

extension CategoryTableViewCell {
    private func addUIElements() {
        contentView.addSubview(categoryName)
        contentView.addSubview(checkmarkButton)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            categoryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryName.heightAnchor.constraint(equalToConstant: 65),
            
            //
            checkmarkButton.centerYAnchor.constraint(equalTo: categoryName.centerYAnchor),
            checkmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 24),
            checkmarkButton.widthAnchor.constraint(equalToConstant: 24),
            
        ])
    }
}
