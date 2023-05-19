import Foundation

struct TrackerCategory {
    let header: String
    var tracker: [Tracker]
    
    mutating func addTracker(_ newTracker: Tracker) {
        tracker.append(newTracker)
    }
}
