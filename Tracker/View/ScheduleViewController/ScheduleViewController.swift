import UIKit

final class ScheduleViewController: UIViewController {
    
    //MARK: - UI elements
    private lazy var scheduleTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var newCategoryButton: UIButton = {
        UIButton.customButton(
            "Готово",
            borderColor: nil,
            titleColor: .YPWhiteDay,
            selector: #selector(addNewCategoryVC),
            target: self,
            cornerRadius: 16,
            borderWidth: nil,
            backgroundColor: .YPBlackDay)
    }()
    
    //MARK: - Private property
    private let weekday = Weekday.allCases
    private var selectedWeekDay = [Weekday]()
    weak var delegate: SaveScheduleListDelegate?
    
    @objc
    private func addNewCategoryVC() {
        delegate?.saveSchedule(category: selectedWeekDay)
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUIElement()
        setConstraints()
        settingsTableView()
    }
}

//MARK: - Conform ScheduleTableViewCellDelegate
extension ScheduleViewController: ScheduleTableViewCellDelegate {
    func saveWeekDay(day: Weekday) {
        selectedWeekDay.append(day)
    }
    
    func deleteWeekDay(day: Weekday) {
        guard let index = selectedWeekDay.firstIndex(of: day) else { return }
        selectedWeekDay.remove(at: index)
    }
}


//MARK: - Conform UITableViewDelegate & UITableViewDataSource
extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weekday.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = weekday[indexPath.row]
        let cell = scheduleTableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.reuseIdentifier, for: indexPath) as! ScheduleTableViewCell
        cell.configurationCell(title: data)
        cell.delegate = self
        cell.contentView.backgroundColor = .YPBackgroundDay
        return cell
    }
}

//MARK: - Set UI elements
private extension ScheduleViewController {
    private func settingsTableView() {
        scheduleTableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.reuseIdentifier)
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self
        scheduleTableView.rowHeight = 75
        scheduleTableView.backgroundColor = .YPWhiteDay
        scheduleTableView.allowsSelection = false
    }
    
    private func addUIElement() {
        view.addSubview(scheduleTableView)
        scheduleTableView.addSubview(newCategoryButton)
        view.backgroundColor = .YPWhiteDay
        navigationItem.title = "Расписание"
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            //
            scheduleTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scheduleTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scheduleTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scheduleTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //
            newCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            newCategoryButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
