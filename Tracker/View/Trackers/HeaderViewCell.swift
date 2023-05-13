
import UIKit

final class HeaderViewCell: UICollectionReusableView {
    //MARK: - Static id
    static var reuseIdentifier: String {
        return String(describing: TrackersUICollectionCell.self)
    }
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.sfProBold(size: 19)
        label.textColor = .YPBlackDay
        label.frame = bounds
        return label
    }()
    
     func configurateHeader(header: String) {
        addUIElement()
        title.text = header
         
     }
    
    private func addUIElement(){
        addSubview(title)
        title.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        title.heightAnchor.constraint(equalToConstant: 20).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

}
