import Foundation

protocol SaveCategoryDelegate: AnyObject {
    func saveCategory(category: String?)
}

protocol SaveTitleReminder: AnyObject {
    func saveTitle(title: String?)
}

