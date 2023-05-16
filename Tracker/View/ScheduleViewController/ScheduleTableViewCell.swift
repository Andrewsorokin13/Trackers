import UIKit

final class ScheduleTableViewCell: UITableViewCell {
    
    //MARK: - Static id
    static var reuseIdentifier: String {
        return String(describing: ScheduleTableViewCell.self)
    }
    
    //MARK: - UI elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.sfProMedium(size: 16)
        return label
    }()
    
    private lazy var switchView: UISwitch = {
        let switchView = UISwitch(frame: .zero)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.setOn(false, animated: true)
        switchView.onTintColor = .YPBlue
        switchView.addTarget(self, action: #selector(self.switchChanged), for: .valueChanged)
        return switchView
    }()
    
    //MARK: - Delegate
    weak var delegate: ScheduleTableViewCellDelegate?
    private var currentWeekday: Weekday = Weekday.Friday
    
    //MARK: - Internal func Configuration Cell
    func configurationCell(title: Weekday) {
        addUIElements()
        setConstraints()
        titleLabel.text = title.fullName
        self.currentWeekday = title
    }
    
    @objc
    private func switchChanged(_ sender : UISwitch) {
        if sender.isOn {
            delegate?.saveWeekDay(day: currentWeekday)
        } else {
            delegate?.deleteWeekDay(day: currentWeekday)
        }
    }
}

//MARK: - Set UI elements
private extension ScheduleTableViewCell {
    private func addUIElements() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(switchView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            switchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            switchView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
