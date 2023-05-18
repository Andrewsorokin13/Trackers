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
        label.clipsToBounds = true
        label.font = UIFont.sfProMedium(size: 16)
        label.textAlignment = .center
        label.backgroundColor = .YPBackgroundDay
        label.layer.cornerRadius = 12
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
        let button = UIButton(type: .system)
        let pointSize = UIImage.SymbolConfiguration(pointSize: 10)
        let image = UIImage(systemName: "testPlusButton", withConfiguration: pointSize)
        button.addTarget(self, action:  #selector(buttonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 34).isActive = true
        button.heightAnchor.constraint(equalToConstant: 34).isActive = true
        button.tintColor = .YPWhiteDay
        button.setImage(image, for: .normal)
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
    
    func cellConfigurate(tracker: Tracker, isComplete: Bool, indexPath: IndexPath, completedDay: Int) {
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
        
        
        dayLabel.text = nameDays(completedDay)
        
        let image = setImageButton(isComleteReminder)
        let alpha = isComleteReminder ? 0.5 : 1
        plusButton.setImage(image, for: .normal)
        plusButton.alpha = alpha
    }
    
 
   
    private func setImageButton(_ isComleteReminder: Bool) -> UIImage {
        let pointSize = UIImage.SymbolConfiguration(pointSize: 11)
        let imagePlus = UIImage(systemName: "plus", withConfiguration: pointSize)
        let imageCheckmark = UIImage(systemName: "checkmark", withConfiguration: pointSize)
        let image = isComleteReminder ? imageCheckmark : imagePlus
        guard let image = image else { return UIImage() }
        
        return image
    }
    
    private func nameDays(_ count: Int) -> String {
      let singular = count % 10
      let plural = count % 100
    
        if singular == 1 && plural != 11 {
            return "\(count) день"
        } else if singular >= 2 && singular <= 4 {
            return "\(count) дня"
        } else {
            return "\(count) дней"
        }
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
            taskView.heightAnchor.constraint(equalToConstant: 90),
            
            //
            emojiLabel.leadingAnchor.constraint(equalTo: taskView.leadingAnchor, constant: 12),
            emojiLabel.topAnchor.constraint(equalTo: taskView.topAnchor, constant: 12),
            emojiLabel.widthAnchor.constraint(equalToConstant: 24),
            emojiLabel.heightAnchor.constraint(equalToConstant: 24),
            
            //
            reminderLabel.leadingAnchor.constraint(equalTo: emojiLabel.leadingAnchor),
            reminderLabel.trailingAnchor.constraint(equalTo: taskView.trailingAnchor, constant: -12),
            reminderLabel.bottomAnchor.constraint(equalTo: taskView.bottomAnchor, constant: -10),
            reminderLabel.heightAnchor.constraint(equalToConstant: 34),
            
            timeTrackerHorizontalStack.leadingAnchor.constraint(equalTo: emojiLabel.leadingAnchor,constant: 12),
            timeTrackerHorizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            timeTrackerHorizontalStack.topAnchor.constraint(equalTo: taskView.bottomAnchor, constant: 8),
            timeTrackerHorizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
}
