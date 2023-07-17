import Foundation

struct Constant {
    
    struct CollectionItems {
        static let main = ["Категогия"]
        static let emojiArray = ["🙂", "😻","🌺","🐶", "❤️", "😱", "😇", "😡", "🥶", "🤔", "🙌", "🍔", "🥦", "🏓", "🥇", "🎸", "🏝", "😪"]
        static let colorArray = (1...18).map { "\($0)" }
    }
    
    struct Event {
     static let newRegularEvent = EventModel(title: "Регулярное событие", model: EventSectionModel (
            list: ["Категогии", "Расписание"],
            textField: [""],
            emoji: Constant.CollectionItems.emojiArray,
            color: Constant.CollectionItems.colorArray
        ))
      static let newIrRegularEvent =  EventModel(title: "Не регулярное событие", model: EventSectionModel (
        list: ["Категогии"],
        textField: [""],
        emoji: Constant.CollectionItems.emojiArray,
        color: Constant.CollectionItems.colorArray
    ))
    }
    
    struct ScheduleTableView {
        static let weekDayArray = ["Понедельник","Вторник","Среда","Четверг","Пятница","Суббота","Воскресенье"]
    }
}
