import UIKit

final class TrackersUICollectionCell: UICollectionViewCell {
    
    //MARK: - Static id
    static var reuseIdentifier: String {
        return String(describing: TrackersUICollectionCell.self)
    }
    
    //MARK: - UI elements
    private lazy var taskView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var reminderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.sfProMedium(size: 12)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 24 / 2
        label.font = UIFont.sfProMedium(size: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .YPBlackDay
        label.font = UIFont.sfProMedium(size: 12)
        return label
    }()
    
    private lazy var timeTrackerHorizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var plusButton: UIButton = {
        let pointSize = UIImage.SymbolConfiguration(pointSize: 11)
        let image = UIImage(systemName: "plus", withConfiguration: pointSize)
        let button = UIButton.systemButton(with: image!, target: self, action:  #selector(buttonTap))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 34).isActive = true
        button.heightAnchor.constraint(equalToConstant: 34).isActive = true
        button.tintColor = .YPWhiteDay
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()
    
    weak var delegate: TrackerCellDelegate?
    private var isComleteReminder: Bool = false
    private var trackerID: UUID?
    private var indexPath: IndexPath?
    
    @objc
    private func buttonTap() {
        guard let indexPath = indexPath, let id = trackerID else { return  }
        if isComleteReminder {
            delegate?.uncopleteTracker(id: id, indexPath: indexPath)
        }else {
            delegate?.completeTracker(id: id, indexPath: indexPath)
        }
    }
    
    func cellConfigurate(tracker: Tracker, isComplete: Bool, indexPath: IndexPath) {
        addUIElemets()
        setconstraints()
        self.trackerID = tracker.id
        self.isComleteReminder = isComplete
        self.indexPath = indexPath
        let taskBackgroundColor = tracker.color
        
        taskView.backgroundColor = taskBackgroundColor
        plusButton.backgroundColor = taskBackgroundColor
        reminderLabel.text = tracker.title
        emojiLabel.text = tracker.emoji ?? ""
        let day = (1...5).randomElement()
        
        dayLabel.text = "\(day!) дней"
        let image = isComleteReminder ? UIImage(systemName: "checkmark") : UIImage(systemName: "plus")
        plusButton.setImage(image, for: .normal)
    }
    
}


//MARK: - Set UI elements
private extension TrackersUICollectionCell {
    private func addUIElemets() {
        //
        contentView.addSubview(taskView)
        contentView.addSubview(timeTrackerHorizontalStack)
        //
        taskView.addSubview(emojiLabel)
        taskView.addSubview(reminderLabel)
        //
        timeTrackerHorizontalStack.addArrangedSubview(dayLabel)
        timeTrackerHorizontalStack.addArrangedSubview(plusButton)
    }
    
    private func setconstraints() {
        NSLayoutConstraint.activate([
            //
            taskView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            taskView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            taskView.topAnchor.constraint(equalTo: contentView.topAnchor),
            taskView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            
            //
            emojiLabel.leadingAnchor.constraint(equalTo: taskView.leadingAnchor, constant: 12),
            emojiLabel.topAnchor.constraint(equalTo: taskView.topAnchor, constant: 12),
            emojiLabel.widthAnchor.constraint(equalToConstant: 24),
            emojiLabel.heightAnchor.constraint(equalToConstant: 24),
            
            //
            reminderLabel.leadingAnchor.constraint(equalTo: emojiLabel.leadingAnchor),
            reminderLabel.trailingAnchor.constraint(equalTo: taskView.trailingAnchor),
            reminderLabel.bottomAnchor.constraint(equalTo: taskView.bottomAnchor, constant: -10),
            
            timeTrackerHorizontalStack.leadingAnchor.constraint(equalTo: emojiLabel.leadingAnchor),
            timeTrackerHorizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            timeTrackerHorizontalStack.topAnchor.constraint(equalTo: taskView.bottomAnchor, constant: 2),
            timeTrackerHorizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
}
