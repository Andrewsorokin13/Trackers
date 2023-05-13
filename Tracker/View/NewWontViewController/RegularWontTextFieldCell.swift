import UIKit

final class RegularWontTextFieldCell: UITableViewCell {
    
    //MARK: - UI element
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите название трекера"
        return textField
    }()

    //MARK: - Internal func Configuration Cell
    func configurationCell() {
        addUIElements()
        setConstraints()
        textField.delegate = self
    }
}

//MARK: - Conform UITextFieldDelegate
extension RegularWontTextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


//MARK: - Set UI elements
extension RegularWontTextFieldCell {
    private func addUIElements() {
        contentView.addSubview(textField)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
