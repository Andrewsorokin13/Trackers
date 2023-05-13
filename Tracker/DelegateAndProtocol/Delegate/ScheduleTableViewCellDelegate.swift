import Foundation

protocol ScheduleTableViewCellDelegate: AnyObject {
    func saveWeekDay(day: String)
    func deleteWeekDay(day: String)
}
