import UIKit

protocol testSaveDelegate: AnyObject {
    func testSave(category: [Weekday])
}

final class ScheduleViewController: UIViewController {
    
    //MARK: - UI elements
    private lazy var scheduleTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var scheduleButton: UIButton = {
        UIButton.customButton(
            "Готово",
            borderColor: nil,
            titleColor: .YPWhiteDay,
            selector: #selector(addNewScheduleWeekday),
            target: self,
            cornerRadius: 16,
            borderWidth: nil,
            backgroundColor: .YPBlackDay)
    }()
    
    //MARK: - Private property
    private let viewModel = ScheduleViewModel()
    weak var delegate: SaveScheduleListDelegate?
    
    //MARK: - Action button
    @objc
    private func addNewScheduleWeekday() {
        delegate?.saveSchedule(category: viewModel.selectedWeekDay)
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUIElement()
        setConstraints()
        settingsTableView()
    }
}

//MARK: - Conform UITableViewDelegate & UITableViewDataSource
extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.getWeekDay(at: indexPath.row)
        guard let cell = scheduleTableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.reuseIdentifier, for: indexPath) as? ScheduleTableViewCell
        else { return UITableViewCell() }
        cell.configurationCell(title: data)
        cell.delegate = self
        cell.contentView.backgroundColor = .YPBackgroundDay
        return cell
    }
}

//MARK: - Conform ScheduleTableViewCellDelegate
extension ScheduleViewController: ScheduleTableViewCellDelegate {
    func saveWeekDay(day: Weekday) {
        viewModel.saveWeekDay(day: day)
    }
    
    func deleteWeekDay(day: Weekday) {
        viewModel.deleteWeekDay(day: day)
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
        scheduleTableView.addSubview(scheduleButton)
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
            scheduleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scheduleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scheduleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            scheduleButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
