import Foundation

enum Weekday: CaseIterable {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
    
    var fullName: String {
        switch self {
        case .Monday: return "Понедельник"
        case .Tuesday: return "Вторник"
        case .Wednesday: return "Среда"
        case .Thursday: return "Четверг"
        case .Friday: return "Пятница"
        case .Saturday: return "Суббота"
        case .Sunday: return "Воскресенье"
        }
    }
    
    var weekNumber: Int {
        switch self {
        case .Monday: return 1
        case .Tuesday: return 2
        case .Wednesday: return 3
        case .Thursday: return 4
        case .Friday: return 5
        case .Saturday: return 6
        case .Sunday: return 7
        }
    }
    var shortName: String {
        switch self {
        case .Monday: return "Пн"
        case .Tuesday: return "Вт"
        case .Wednesday: return "Ср"
        case .Thursday: return "Чт"
        case .Friday: return "Пт"
        case .Saturday: return "Сб"
        case .Sunday: return "Вс"
        }
    }
}

