import UIKit


extension UIButton {
    static func customButton(_ title: String, borderColor: UIColor?, titleColor: UIColor?, selector: Selector, target: Any?, cornerRadius: CGFloat? , borderWidth: CGFloat?, backgroundColor: UIColor?) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.addTarget(target, action: selector, for: .touchUpInside)
        button.layer.cornerRadius = cornerRadius ?? 0
        button.layer.borderColor = borderColor?.cgColor
        button.layer.borderWidth = borderWidth ?? 0
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.sfProMedium(size: 16)
        return button
    }
}
