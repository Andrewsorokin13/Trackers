import Foundation
import UIKit

protocol TableViewCategoryDelegate: AnyObject {
    func selectedCategory(name: String)
}

final class CategoryTableViewController: UIViewController {
    
    weak var delegate: TableViewCategoryDelegate?
    
    private lazy var viewModel = CategoryTableViewModel()
    
    private lazy var tableView: UITableView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUIElement()
        setConstraints()
        settingsTableView()
    }
    
    //MARK: - Objc func
    @objc
    private func saveCategory() {
        delegate?.selectedCategory(name: viewModel.nameCategory)
        dismiss(animated: true)
    }
}

extension CategoryTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        let title = viewModel.titleCategoryForIndex(at: indexPath)
        cell.configure(with: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didSelectRowCheckmark(at: indexPath, tableView: tableView)
    }
}

extension CategoryTableViewController {
    
    private func settingsTableView() {
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 75
    }
    
    private func addUIElement() {
        view.addSubview(tableView)
        view.addSubview(newCategoryButton)
        
        navigationItem.title = "Категория"
        view.backgroundColor = .YPWhiteDay
        tableView.backgroundColor = .YPWhiteDay
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            //
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: newCategoryButton.topAnchor),
            //
            newCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            newCategoryButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
