import UIKit

final class SectionHeaderReusableView: UICollectionReusableView {
    
    //MARK: - Static Identifier
    static var reuseIdentifier: String {
        return String(describing: SectionHeaderReusableView.self)
    }
    
    //MARK: - UI Element
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.sfProBold(size: 19)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(
            .defaultHigh, for: .horizontal)
        return label
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: readableContentGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: readableContentGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 10),
            titleLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
