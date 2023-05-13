import UIKit

final class EmojiCollectionCell: UICollectionViewCell {
    static var reuseIdentifier: String {
      return String(describing: EmojiCollectionCell.self)
    }
    
    private lazy var emojiLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 33)
        return label
    }()
    
    func configurationCell(emoji: String) {
        addUIEllement()
        setContsraints()
        emojiLable.text = emoji
    }
}

private extension EmojiCollectionCell {
    private func addUIEllement() {
        contentView.addSubview(emojiLable)
    }
    
    private func setContsraints() {
        NSLayoutConstraint.activate([
            emojiLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emojiLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            emojiLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            emojiLable.topAnchor.constraint(equalTo: contentView.topAnchor),
            emojiLable.heightAnchor.constraint(equalToConstant: 52),
            emojiLable.widthAnchor.constraint(equalToConstant: 52)
        ])
    }
}
