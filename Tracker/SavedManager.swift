import Foundation
import UIKit

final class MocSaveManager {
    static let shared = MocSaveManager()
    
    static let didChangeNotification = Notification.Name("MocSaveManagerDidChange")
    
    private init() {}
    
    private var trackerCategory: [TrackerCategory] = [
        TrackerCategory(header: "Первая категория",
                        tracer: [
                            Tracker(id: UUID(),
                                    title: "Выполните задачу в Xcode",
                                    color: .YPRed,
                                    emoji: Constant.CollectionItems.emojiArray.randomElement(),
                                    schedule: [Weekday.Monday]),

                            Tracker(id: UUID(),
                                    title: "После проверки по чек-листу залейте готовую задачу в ваш проект на GitHub в отдельную ветку с названием sprint_14",
                                    color: .YPGray,
                                    emoji: Constant.CollectionItems.emojiArray.randomElement(),
                                    schedule: [Weekday.Monday]),

                            Tracker(id: UUID(),
                                    title: "Создайте Pull Request (ПР) и скопируйте ссылку на него",
                                    color: .YPBlue,
                                    emoji: Constant.CollectionItems.emojiArray.randomElement(),
                                    schedule: [Weekday.Saturday])
                        ]),
        TrackerCategory(header: "Вторая категория",
                        tracer:[
                            Tracker(id: UUID(),
                                    title: "Приложение должно поддерживать устройства iPhone с iOS 13.4 или выше.",
                                    color: .brown,
                                    emoji: Constant.CollectionItems.emojiArray.randomElement(),
                                    schedule: [Weekday.Thursday]),

                            Tracker(id: UUID(),
                                    title: "Tracker[17222:1798608] [Snapshot",
                                    color: .purple,
                                    emoji: Constant.CollectionItems.emojiArray.randomElement(),
                                    schedule: [Weekday.Wednesday, Weekday.Thursday, Weekday.Friday])
                        ])
    ]
    
    func readTrackerCategory() -> [TrackerCategory] {
        trackerCategory
    }
    
    
    func saveNewTracker(category: String, tracker: Tracker ) {
        trackerCategory.append(
            TrackerCategory(header: category, tracer: [ tracker ] )
        )
        NotificationCenter.default.post(name: MocSaveManager.didChangeNotification,
                                        object: self,
                                        userInfo: ["tracker": trackerCategory])
    }
}
