import Foundation
import UIKit

struct Tracker {
    let trackerID: UUID
    let title: String
    let color: String
    let emoji: String?
    let schedule: [Weekday]?
}
