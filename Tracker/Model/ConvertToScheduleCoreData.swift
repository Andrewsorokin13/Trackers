import Foundation

final class ConvertToScheduleCoreData {
    
    static let shared = ConvertToScheduleCoreData()
    
    private init() {}
    
    func weekdayConvertToString(from day: [Weekday]) -> String {
        var stringDay = ""
        for weekDay in day {
            switch weekDay {
            case .Monday: stringDay += "Пн "
            case .Tuesday: stringDay += "Вт "
            case .Wednesday: stringDay += "Ср "
            case .Thursday: stringDay += "Чт "
            case .Friday: stringDay += "Пт "
            case .Saturday: stringDay += "Сб "
            case .Sunday: stringDay += "Вс "
            }
        }
        return stringDay
    }
    
    func stringToWeekday(from string: String) -> [Weekday] {
        var weekDay = [Weekday]()
        let dayToString = string.components(separatedBy: " ")
        for day in dayToString {
            switch day {
            case "Пн": weekDay.append(.Monday)
            case "Вт": weekDay.append(.Tuesday)
            case "Ср": weekDay.append(.Wednesday)
            case "Чт": weekDay.append(.Thursday)
            case "Пт": weekDay.append(.Friday)
            case "Сб": weekDay.append(.Saturday)
            case "Вс": weekDay.append(.Sunday)
            default: break
            }
        }
        return weekDay
    }
}
