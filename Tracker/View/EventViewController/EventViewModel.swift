import Foundation
import UIKit
protocol EventViewModelProtocol {
    func reloadItem()
}

final class EventViewModel {
    
    private var textFieldText = ""
    private var category = ""
    private var emoji = ""
    private var colorText = ""
    private var schedule: [Weekday]?

      
    private var model: EventModel?
    private (set) var title: String = ""
    
    private let storeManager = SaveManagerDidChange.shared
  
    
    init(model: EventModel) {
        self.model = model
        self.title = model.title
    }
    
    func saveText(text: String) {
        self.textFieldText = text
    }
    
    
    func saveCategory(text: String) {
        self.category = text
    }
        
    func saveColor(indexPath: IndexPath) {
        guard let model = model else { return }
        self.colorText = model.model.color[indexPath.row]
    }
    
    func saveEvent() {
        let currentWeekday = getCurrentWeekday()
        storeManager.addNewTracker(name: textFieldText, emoji: emoji, color: colorText, schedule: schedule ?? [currentWeekday], category: category)
    }
    
    func addSchedule(day: [Weekday] ) {
        schedule = day
    }
    
    func getEventModel() -> EventSectionModel? {
        return model?.model
    }
    
    func getCollectionViewSnapshot() -> EventSectionModel? {
        return model?.model
    }
    
    func getEventModel(model: EventModel) -> EventSectionModel {
        return model.model
    }
    
    func getElement(indexPath: IndexPath){
        guard let model = model else { return }
        self.emoji = model.model.emoji[indexPath.row]
    }
    
    private func getCurrentWeekday() -> Weekday {
        let calendar = Calendar.current
        let todayDate = Date()
        let dayOfWeek = calendar.component(.weekday, from: todayDate)
        return Weekday.allCases[dayOfWeek - 1]
    }
}

