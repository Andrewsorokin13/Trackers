
import UIKit

final class CategoryTableViewModel  {
    
    private var category: [String] = ["Первая категория", "Вторая категория", "Третья категория"]
    private var selectedRowCheckmark = -1
    private(set) var nameCategory = ""
    
    func numberOfRowsInSection() -> Int {
        return category.count
    }
    
    func titleCategoryForIndex(at indexPath: IndexPath) -> String {
        return category[indexPath.row]
    }
    
    func didSelectRowCheckmark(at indexPath: IndexPath, tableView: UITableView)  {
        let selectedRow = selectedRowCheckmark
        if selectedRow == indexPath.row {
            return
        }
        if let previousCell = tableView.cellForRow(at: IndexPath(row: selectedRowCheckmark, section: indexPath.section)) {
            previousCell.accessoryType = .none
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            self.nameCategory = category[indexPath.row]
        }
        selectedRowCheckmark = indexPath.row
    }
}
