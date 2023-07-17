import UIKit

protocol SaveTextFieldDelegate {
    func saveTextField(text: String)
}

final class TextFieldCollectionViewCell: UICollectionViewCell {
    //MARK: - Static Identifier
    static var reuseIdentifier: String {
        return String(describing: TextFieldCollectionViewCell.self)
    }
    //MARK: - Private property
    private let maxCharacters = 38
    var delegate: SaveTextFieldDelegate?
    
    //MARK: - UI elements
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите название трекера"
        textField.font = UIFont.sfProRegular(size: 17)
        textField.backgroundColor = .clear
        return textField
    }()
    
    private lazy var showErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .YPRed
        label.font = UIFont.sfProRegular(size: 17)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var clearTextFieldButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "xmarkCircle")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        return button
    }()
    
    private lazy var textFieldBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    //MARK: - Button action
    @objc
    private func clearTextField() {
        textField.text = ""
        showErrorLabel.isHidden = true
        clearTextFieldButton.isHidden = true
    }
    
    //MARK: - Internal func Configuration Cell
    func configurationCell() {
        textField.delegate = self
        clearTextFieldButton.isHidden = true
        addUIElements()
        setConstraints()
        contentView.backgroundColor = .YPBackgroundDay
    }
}

//MARK: - Conform UITextFieldDelegate
extension TextFieldCollectionViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = textField.text!.count + string.count - range.length
        
        if newLength > maxCharacters {
            showErrorLabel.isHidden = false
            showErrorLabel.text = "Ограничение 38 символов"
            return false
        } else {
            showErrorLabel.isHidden = true
            clearTextFieldButton.isHidden = textField.text == ""
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.saveTextField(text: textField.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.saveTextField(text: textField.text ?? "")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        clearTextFieldButton.isHidden = true
        return true
    }
}

//MARK: - Set UI elements
extension TextFieldCollectionViewCell {
    private func addUIElements() {
        contentView.addSubview(textFieldBackground)
        textFieldBackground.addSubview(textField)
        textFieldBackground.addSubview(clearTextFieldButton)
        textFieldBackground.addSubview(showErrorLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            textFieldBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textFieldBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textFieldBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            textFieldBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            //
            textField.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: clearTextFieldButton.leadingAnchor, constant: -10),
            textField.centerYAnchor.constraint(equalTo: textFieldBackground.centerYAnchor),
            //
            clearTextFieldButton.heightAnchor.constraint(equalToConstant: 17),
            clearTextFieldButton.widthAnchor.constraint(equalToConstant: 17),
            clearTextFieldButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            clearTextFieldButton.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor, constant: -6),
            clearTextFieldButton.topAnchor.constraint(equalTo: textField.topAnchor),
            //
            showErrorLabel.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor),
            showErrorLabel.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor, constant: -8),
            showErrorLabel.topAnchor.constraint(equalTo: textFieldBackground.bottomAnchor, constant: 8),
            showErrorLabel.heightAnchor.constraint(equalToConstant: 17)
        ])
    }
}
