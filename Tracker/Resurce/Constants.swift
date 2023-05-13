import Foundation

struct Constant {
    
    struct CollectionItems {
        static let main = ["Категогия"]
        static let emojiArray = ["🙂", "😻","🌺","🐶", "❤️", "😱", "😇", "😡", "🥶", "🤔", "🙌", "🍔", "🥦", "🏓", "🥇", "🎸", "🏝", "😪"]
        static let colorArray = (1...18).map { "\($0)" }
    }
    
    struct ScheduleTableView {
        static let weekDayArray = ["Понедельник","Вторник","Среда","Четверг","Пятница","Суббота","Воскресенье"]
    }
    
    struct NewWontVCStaticLet {
        static let listCount = [["Textfiled"],["Категогии", "Расписание"]]
    }
    
}
