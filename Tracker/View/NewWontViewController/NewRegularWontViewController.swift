import UIKit

final class NewRegularWontViewController: UIViewController{
 
    //MARK: - UI elements
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let horizontalStackBottomButton: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var createButton: UIButton = {
        UIButton.customButton(
            "Создать",
            borderColor: nil,
            titleColor: UIColor.YPWhiteDay,
            selector: #selector(saveNewRegularWont),
            target: self,
            cornerRadius: 16,
            borderWidth: nil,
            backgroundColor: UIColor.YPGray)
    }()
    
    private lazy var cancelButton: UIButton = {
        UIButton.customButton(
            "Отменить",
            borderColor: UIColor.YPRed,
            titleColor: UIColor.YPRed,
            selector: #selector(cancelsaveNewRegularWont),
            target: self,
            cornerRadius: 15,
            borderWidth: 1,
            backgroundColor: nil)
    }()
    
    //MARK: Private property
    private let mocManager = MocSaveManager.shared
    private let main = Constant.NewWontVCStaticLet.listCount
    private var textInTextField: String?
    private var scheduleArray = Set<String>()
    private var categoryArray = Set<String>()
    
    //MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        configureTableView()
        view.backgroundColor = .YPWhiteDay
        navigationItem.title = "Новая привычка"
    }
    
    //MARK: - Objc func
    @objc
    private func cancelsaveNewRegularWont() {
        dismiss(animated: true)
    }
    
    @objc
    private func saveNewRegularWont() {
        dismiss(animated: true)
    }
    
    //MARK: - Private func
    private func createNewTracker() -> Tracker {
        let color =  (1...18).map { "\($0)" }
        let string =  color.randomElement()
        return Tracker(id: UUID(), title: "", color: UIColor(named: string!)!, emoji: "🎈", schedule: [Weekday.monday])
    }
    
    private func convertArraytoString(array: Set<String>) -> String {
        return array.joined(separator: ",")
    }
    

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(RegularWontTextFieldCell.self, forCellReuseIdentifier: "cell")
        tableView.register(RegularWontCategoryCell.self, forCellReuseIdentifier: RegularWontCategoryCell.reuseIdentifier)
        tableView.rowHeight = 75
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .YPWhiteDay
    }
}

//MARK: - Conform SaveScheduleListDelegate & SaveCategoryDelegate
extension NewRegularWontViewController: SaveScheduleListDelegate, SaveCategoryDelegate {
    
    func saveCategory(category: String?) {
        guard let category = category else { return  }
        categoryArray.insert(category)
        tableView.reloadData()
    }
    
    func saveSchedule(category: Set<String>) {
        self.scheduleArray = category
        tableView.reloadData()
    }
}

//MARK: - Conform UITableViewDelegate & UITableViewDataSource
extension NewRegularWontViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        main[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case  0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RegularWontTextFieldCell  else { return UITableViewCell() }
            cell.configurationCell()
            cell.contentView.backgroundColor = .YPBackgroundDay
            return cell
        default :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RegularWontCategoryCell.reuseIdentifier, for: indexPath) as? RegularWontCategoryCell  else { return UITableViewCell() }
            if indexPath.row == 0 {
                let data = convertArraytoString(array: categoryArray)
                cell.configurationCell(text: main.last?[indexPath.row], detail: "\(data)")
            }else {
                let data = convertArraytoString(array: scheduleArray)
                cell.configurationCell(text: main.last?[indexPath.row], detail: "\(data)")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectVCForIndexPath(indexPath: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        main.count
    }
    
    private func selectVCForIndexPath(indexPath: IndexPath){
        if indexPath.row == 1 {
            let vc = ScheduleViewController()
            vc.delegate = self
            let navigationVC = UINavigationController(rootViewController: vc)
            present(navigationVC, animated: true)
        }else {
            let vc = CategoryViewController()
            vc.delegate = self
            let navigationVC = UINavigationController(rootViewController: vc)
            present(navigationVC, animated: true)
        }
    }
}

//MARK: - Set UI elements
private extension NewRegularWontViewController {
    private func setConstraint() {
        //
        view.backgroundColor = .YPWhiteDay
        view.addSubview(horizontalStackBottomButton)
        view.addSubview(tableView)
        //
        horizontalStackBottomButton.addArrangedSubview(cancelButton)
        horizontalStackBottomButton.addArrangedSubview(createButton)
        
        NSLayoutConstraint.activate([
            horizontalStackBottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            horizontalStackBottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            horizontalStackBottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            horizontalStackBottomButton.heightAnchor.constraint(equalToConstant: 60),
            //
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: horizontalStackBottomButton.topAnchor)
            
        ])
    }
}
