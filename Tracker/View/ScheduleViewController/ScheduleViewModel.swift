import Foundation

final class ScheduleViewModel {
    private let weekDay = Weekday.allCases
    private(set) var selectedWeekDay = [Weekday]()
    
    func saveWeekDay(day: Weekday) {
        selectedWeekDay.append(day)
    }
    
    func deleteWeekDay(day: Weekday) {
        guard let index = selectedWeekDay.firstIndex(of: day) else { return }
        selectedWeekDay.remove(at: index)
    }
    
    func numberOfRowsInSection() -> Int {
        return weekDay.count
    }
    
    func getWeekDay(at index: Int) -> Weekday {
        return weekDay[index]
    }
}
