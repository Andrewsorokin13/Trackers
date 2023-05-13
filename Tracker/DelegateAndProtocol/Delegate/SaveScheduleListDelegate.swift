import Foundation

protocol SaveScheduleListDelegate: AnyObject {
    func saveSchedule(category: Set<String>)
}
