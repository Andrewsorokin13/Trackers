import UIKit

final class  AddNewCategoryViewController: UIViewController {
    
    //MARK: - UI Elements
    private lazy var textFieldBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .YPLightGray
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var categoryTextfield: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .YPBlackDay
        textField.placeholder = "Введите название категории"
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.delegate = self
        return textField
    }()
    
    private lazy var completeButton: UIButton = {
        let button = UIButton.customButton(
            "Готово",
            borderColor: nil,
            titleColor: .YPWhiteDay,
            selector: #selector(saveCategory),
            target: self,
            cornerRadius: 16,
            borderWidth: nil,
            backgroundColor: .YPBlackDay)
        return button
    }()
    
    //MARK: - Delegate
    weak var delegate: AddNewCategoryDelegate?
    
    @objc
    private func saveCategory() {
        delegate?.addNewCategoryToListCategory(category: categoryTextfield.text)
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUIElement()
        setConstraint()
    }
}

//MARK: - Conform UITextFieldDelegate
extension AddNewCategoryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

//MARK: - Set UI elements
private extension AddNewCategoryViewController {
    private func addUIElement() {
        view.backgroundColor = .YPWhiteDay
        view.addSubview(textFieldBackgroundView)
        view.addSubview(completeButton)
        
        textFieldBackgroundView.addSubview(categoryTextfield)
        navigationItem.title = "Новая категория"
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            //
            textFieldBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            textFieldBackgroundView.heightAnchor.constraint(equalToConstant: 75),
            //
            categoryTextfield.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor, constant: 8),
            categoryTextfield.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor, constant: -8),
            categoryTextfield.topAnchor.constraint(equalTo: textFieldBackgroundView.topAnchor),
            categoryTextfield.bottomAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor),
            //
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            completeButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}
