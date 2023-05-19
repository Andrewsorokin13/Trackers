import UIKit

final class ListCategoryViewController: UIViewController {
    
    //MARK: - UI elements
    private lazy var categoryTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var newCategoryButton: UIButton = {
        UIButton.customButton(
            "Добавить категорию",
            borderColor: nil,
            titleColor: .YPWhiteDay,
            selector: #selector(saveCategory),
            target: self,
            cornerRadius: 16,
            borderWidth: nil,
            backgroundColor: .YPBlackDay)
    }()
    
    //MARK: - private propperty
    private var mocCategory = [
        "Важное",
        "Очень важное",
        "Важнее важного"
    ]
    private var selectedRowCheckmark = -1
    private var nameCategory = ""
    weak var delegate: SaveCategoryDelegate?
    
    //MARK: - Objc func
    @objc
    private func saveCategory() {
        delegate?.saveNewCategory(category: nameCategory)
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
extension ListCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mocCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = mocCategory[indexPath.row]
        guard let cell = categoryTableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        cell.config(label: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let selectedRow = selectedRowCheckmark
        if selectedRow == indexPath.row {
            return
        }
        if let previousCell = tableView.cellForRow(at: IndexPath(row: selectedRowCheckmark, section: indexPath.section)) {
            previousCell.accessoryType = .none
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            self.nameCategory = mocCategory[indexPath.row]
        }
        selectedRowCheckmark = indexPath.row
    }
}


//MARK: - Conform AddNewCategoryDelegate
extension ListCategoryViewController: AddNewCategoryDelegate {
    func addNewCategoryToListCategory(category: String?) {
        guard let category = category else { return }
        mocCategory.append(category)
        categoryTableView.reloadData()
    }
}

//MARK: - Set UI elements
extension ListCategoryViewController {
    private func settingsTableView() {
        categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.rowHeight = 75
    }
    
    private func addUIElement() {
        view.addSubview(categoryTableView)
        view.addSubview(newCategoryButton)
        
        navigationItem.title = "Категория"
        view.backgroundColor = .YPWhiteDay
        categoryTableView.backgroundColor = .YPWhiteDay
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            //
            categoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryTableView.bottomAnchor.constraint(equalTo: newCategoryButton.topAnchor),
            //
            newCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            newCategoryButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

