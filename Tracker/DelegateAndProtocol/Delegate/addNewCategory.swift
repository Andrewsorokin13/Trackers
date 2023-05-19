import Foundation

protocol AddNewCategoryDelegate: AnyObject {
    func addNewCategoryToListCategory(category: String?)
}

protocol SaveTitleReminderDelegate: AnyObject {
    func saveTitle(title: String?)
}

protocol SaveCategoryDelegate: AnyObject {
    func saveNewCategory(category: String?)
}
