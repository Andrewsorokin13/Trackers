import Foundation

final class SaveManagerDidChange {
    //MARK: - Static property
    static let shared = SaveManagerDidChange()
    
    //MARK: - Private property
    private let trackerCategoryStore = TrackerCategoryStore.shared
    private let trackerStore = TrackerStore.shared
    
    private var newTrackers: [Tracker] = []
    private var newTrackerCategory: [TrackerCategory] = []
    
    //MARK: - Private init
    private init() {}
    
    //MARK: - Method
    func addNewTracker(name: String, emoji: String, color: String, schedule: [Weekday], category: String) {
        let tracker = Tracker(trackerID: UUID(), title: name, color: color, emoji: emoji, schedule: schedule)
        newTrackers.append(tracker)
        let newTrackerCategory = TrackerCategory(header: category, tracker: newTrackers)
        do {
            try trackerStore.addNewTracker(tracker, with: newTrackerCategory)
        } catch  {
            print("failed to save category")
        }
    }
}
