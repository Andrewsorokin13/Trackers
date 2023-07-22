import UIKit

final class ColorCollectionCell: UICollectionViewCell {
    //MARK: - Static Identifier
    static var reuseIdentifier: String {
        return String(describing: ColorCollectionCell.self)
    }
    
    //MARK: - UI element
    private lazy var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var colorBackgroundColor: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Private property
    private var borderColor: UIColor?
    
    //MARK: - Configuration cell
    func configurationCell(color: String) {
        addUIEllement()
        setContsraints()
        let color = UIColor(named: color) ?? .YPGray
        colorView.backgroundColor = color
        self.borderColor = color
    }
    
    func configDidSelected(){
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = borderColor?.cgColor
    }
    
    func configDidDeSelected() {
        contentView.layer.borderWidth = .zero
        contentView.layer.borderColor = .none
    }
}

//MARK: - Add UI element
private extension ColorCollectionCell {
    private func addUIEllement() {
        //
        contentView.addSubview(colorBackgroundColor)
        colorBackgroundColor.addSubview(colorView)
        colorView.layer.cornerRadius = 8
    }
    
    private  func setContsraints() {
        NSLayoutConstraint.activate([
            //
            colorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 52),
            colorView.widthAnchor.constraint(equalToConstant: 52),
            //
            colorView.centerXAnchor.constraint(equalTo: colorBackgroundColor.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: colorBackgroundColor.centerYAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 42),
            colorView.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
}
