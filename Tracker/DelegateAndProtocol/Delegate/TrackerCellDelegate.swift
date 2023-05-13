import Foundation

protocol TrackerCellDelegate: AnyObject {
    func completeTracker(id: UUID, indexPath: IndexPath)
    func uncopleteTracker(id: UUID, indexPath: IndexPath)
}
