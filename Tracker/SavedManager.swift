import Foundation
import UIKit

final class MocSaveManager {
    static let shared = MocSaveManager()
    
    private init() {}
    
    var trackerCategory: [TrackerCategory] = [
        TrackerCategory(header: "Первая категория",
                        tracer: [
                            Tracker(id: UUID(),
                                    title: "Выполните задачу в Xcode",
                                    color: .YPRed,
                                    emoji: Constant.CollectionItems.emojiArray.randomElement(),
                                    schedule: [Weekday.monday]),

                            Tracker(id: UUID(),
                                    title: "После проверки по чек-листу залейте готовую задачу в ваш проект на GitHub в отдельную ветку с названием sprint_14",
                                    color: .YPGray,
                                    emoji: Constant.CollectionItems.emojiArray.randomElement(),
                                    schedule: [Weekday.monday]),

                            Tracker(id: UUID(),
                                    title: "Создайте Pull Request (ПР) и скопируйте ссылку на него",
                                    color: .YPBlue,
                                    emoji: Constant.CollectionItems.emojiArray.randomElement(),
                                    schedule: [Weekday.monday])
                        ]),
        TrackerCategory(header: "Вторая категория",
                        tracer:[
                            Tracker(id: UUID(),
                                    title: "Приложение должно поддерживать устройства iPhone с iOS 13.4 или выше.",
                                    color: .brown,
                                    emoji: Constant.CollectionItems.emojiArray.randomElement(),
                                    schedule: [Weekday.monday]),

                            Tracker(id: UUID(),
                                    title: "Tracker[17222:1798608] [Snapshot",
                                    color: .purple,
                                    emoji: Constant.CollectionItems.emojiArray.randomElement(),
                                    schedule: [Weekday.monday])
                        ])
    ]
    
}


