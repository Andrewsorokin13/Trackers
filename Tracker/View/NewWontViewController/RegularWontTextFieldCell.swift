import UIKit

final class RegularWontTextFieldCell: UITableViewCell {
    
    //MARK: - UI element
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите название трекера"
        textField.backgroundColor = .clear
        return textField
    }()
    
    private lazy var textFieldBackgound: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    weak var delegate: SaveTitleReminderDelegate?

    //MARK: - Internal func Configuration Cell
    func configurationCell() {
        addUIElements()
        setConstraints()
        contentView.backgroundColor = .YPBackgroundDay
        textField.delegate = self
    }
}

//MARK: - Conform UITextFieldDelegate
extension RegularWontTextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.saveTitle(title: textField.text)
        return true
    }
}

//MARK: - Set UI elements
extension RegularWontTextFieldCell {
    private func addUIElements() {
        contentView.addSubview(textFieldBackgound)
        textFieldBackgound.addSubview(textField)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            textFieldBackgound.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textFieldBackgound.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textFieldBackgound.topAnchor.constraint(equalTo: contentView.topAnchor),
            textFieldBackgound.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            textField.leadingAnchor.constraint(equalTo: textFieldBackgound.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: textFieldBackgound.trailingAnchor, constant: -10),
            textField.topAnchor.constraint(equalTo: textFieldBackgound.topAnchor),
            textField.bottomAnchor.constraint(equalTo: textFieldBackgound.bottomAnchor),
        ])
    }
}
