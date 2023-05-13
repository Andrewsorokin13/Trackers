import UIKit

final class ListCategoryViewController: UIViewController {
    
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
            selector: #selector(addNewCategoryVC),
            target: self,
            cornerRadius: 16,
            borderWidth: nil,
            backgroundColor: .YPBlackDay)
    }()
    
    let testData = [TrackerCategory]()
    
    
    @objc
    private func addNewCategoryVC() {
        let vc = CategoryViewController()
        let navigationVC = UINavigationController(rootViewController: vc)
        present(navigationVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUIElement()
        setConstraints()
        settingsTableView()
    }
}

extension ListCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = testData[indexPath.row]
        let cell = categoryTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data.header
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
        }
    }
}

extension ListCategoryViewController {
    
    private func settingsTableView() {
        categoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.rowHeight = 75
    }
    
    
    private func addUIElement() {
        view.addSubview(categoryTableView)
        categoryTableView.addSubview(newCategoryButton)
        
        navigationItem.title = "Категория"
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            //
            categoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //
            newCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            newCategoryButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
