import Foundation

protocol ScheduleTableViewCellDelegate: AnyObject {
    func saveWeekDay(day: Weekday)
    func deleteWeekDay(day: Weekday)
}
