import Foundation

enum Weekday: String, CaseIterable {
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday

    
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
        case .Sunday: return 1
        case .Monday: return 2
        case .Tuesday: return 3
        case .Wednesday: return 4
        case .Thursday: return 5
        case .Friday: return 6
        case .Saturday: return 7
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

