import UIKit

final class EmojiCollectionCell: UICollectionViewCell {
    //MARK: - Static Identifier
    static var reuseIdentifier: String {
        return String(describing: EmojiCollectionCell.self)
    }
    
    //MARK: - UI element
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 33)
        return label
    }()
    
    //MARK: - Configuration
    func configurationCell(emoji: String) {
        addUIEllement()
        setContsraints()
        emojiLabel.text = emoji
    }
    
    func configDidSelected() {
        contentView.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 1)
        contentView.layer.cornerRadius = 16
    }
    
    func configDidDeSelected() {
        contentView.backgroundColor = .none
    }
}

//MARK: - Add UI element
private extension EmojiCollectionCell {
    private func addUIEllement() {
        contentView.addSubview(emojiLabel)
    }
    
    private func setContsraints() {
        NSLayoutConstraint.activate([
            emojiLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emojiLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            emojiLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            emojiLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            emojiLabel.heightAnchor.constraint(equalToConstant: 52),
            emojiLabel.widthAnchor.constraint(equalToConstant: 52)
        ])
    }
}
