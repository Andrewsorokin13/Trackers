
import UIKit

final class HeaderViewCell: UICollectionReusableView {
    //MARK: - Static id
    static var reuseIdentifier: String {
        return String(describing: TrackersUICollectionCell.self)
    }
    
    //MARK: - UI element
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.sfProBold(size: 19)
        label.textColor = .YPBlackDay
        label.frame = bounds
        return label
    }()
    
    //MARK: - Configuration header
    func configurateHeader(header: String) {
        addUIElement()
        title.text = header
    }
    
    //MARK: - Add ui element
    private func addUIElement(){
        addSubview(title)
        title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28).isActive = true
        title.heightAnchor.constraint(equalToConstant: 20).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
