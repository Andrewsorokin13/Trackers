import UIKit

final class ColorCollectionCell: UICollectionViewCell {
    static var reuseIdentifier: String {
      return String(describing: ColorCollectionCell.self)
    }
    
    private lazy var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configurationCell(emoji: String) {
        addUIEllement()
        setContsraints()
        colorView.backgroundColor = UIColor(named: emoji)
    }
}

private extension ColorCollectionCell {
    private func addUIEllement() {
        contentView.addSubview(colorView)
        colorView.layer.cornerRadius = 8
    }
    
    private func setContsraints() {
        NSLayoutConstraint.activate([
            colorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 42),
            colorView.widthAnchor.constraint(equalToConstant: 42)
        ])
    }
}
