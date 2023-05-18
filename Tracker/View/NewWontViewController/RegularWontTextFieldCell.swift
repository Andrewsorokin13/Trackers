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
    
    private lazy var textFieldBackground: UIView = {
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
        contentView.addSubview(textFieldBackground)
        textFieldBackground.addSubview(textField)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            textFieldBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textFieldBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textFieldBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            textFieldBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            textField.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor, constant: -10),
            textField.topAnchor.constraint(equalTo: textFieldBackground.topAnchor),
            textField.bottomAnchor.constraint(equalTo: textFieldBackground.bottomAnchor),
        ])
    }
}
