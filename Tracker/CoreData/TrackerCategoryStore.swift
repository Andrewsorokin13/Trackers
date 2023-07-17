import Foundation
import CoreData

enum CategoryTrackerStoreError: Error {
    case decodingError(String)
}

final class TrackerCategoryStore: NSObject {
    
    //MARK: - Static property
    static let shared = TrackerCategoryStore()
    
    //MARK: - Private property
    private let convertToScheduleCoreData = ConvertToScheduleCoreData.shared
    private let context: NSManagedObjectContext
    
    private var fetchedResultsController: NSFetchedResultsController<CategoryTrackerCoreData>!
    private var insertedIndexes: IndexSet?
    private var deletedIndexes: IndexSet?
    private var updatedIndexes: IndexSet?
    private var movedIndexes: Set<TrackerCategoryStoreUpdate.Move>?
    
    //MARK: - Delegate
    weak var delegate: TrackerCategoryStoreDelegate?
    //MARK: - Init
    convenience override init() {
        let context = CoreDataStack.shared.context
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()
        
        let fetchRequest = CategoryTrackerCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "header", ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.fetchedResultsController = controller
        try? controller.performFetch()
    }
    
    //MARK: - Method
    func getCategoryCoreData(_ categoryName: String) throws -> [CategoryTrackerCoreData] {
        let request =  CategoryTrackerCoreData.fetchRequest()
        request.predicate = NSPredicate(format: " %K == %@", #keyPath(CategoryTrackerCoreData.header), categoryName)
        let category = try context.fetch(request)
        return category
    }
    
    func getTrackerCategory() -> [TrackerCategory] {
        do {
          let categories = try readCategory()
          return categories
        } catch let error {
            print(error.localizedDescription)
            return []
        }
    }
  
    
    //MARK: - Private method
    private func readCategory() throws -> [TrackerCategory] {
         guard let categories = fetchedResultsController.fetchedObjects,
               let trackerCategory = try? categories.map({
                   try self.convertCategoryTracker(categoryCoreData: $0)
               })
         else { return [] }
         return trackerCategory
     }
    
    private func convertCategoryTracker(categoryCoreData: CategoryTrackerCoreData) throws -> TrackerCategory {
        guard let name = categoryCoreData.header
        else {
            throw CategoryTrackerStoreError.decodingError("Invalid Name")
        }
        guard let trackers = categoryCoreData.tracker?.allObjects as? [TrackerCoreData] else { throw
            CategoryTrackerStoreError.decodingError("Invalid Trackers")
        }
        return TrackerCategory(header: name, tracker: convertToTrackers(trackerCoreData: trackers))
    }
    
    private func convertToTrackers(trackerCoreData: [TrackerCoreData]) -> [Tracker] {
        var trackers = [Tracker]()
        trackerCoreData.forEach { tracker in
            guard
                let trackerID = tracker.trakerID,
                let trackerName = tracker.nameTracker,
                let trackerEmoji = tracker.emoji,
                let trackerColor = tracker.color else { return }
            guard let trackerSchedule = tracker.schedule else { return }
            trackers.append(
                Tracker(
                    trackerID: trackerID,
                    title: trackerName,
                    color: trackerColor,
                    emoji: trackerEmoji,
                    schedule: convertToScheduleCoreData.stringToWeekday(from: trackerSchedule) )
            )
        }
        return trackers
    }
}

//MARK: - Conform NSFetchedResultsControllerDelegate
extension TrackerCategoryStore: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        insertedIndexes = IndexSet()
        deletedIndexes = IndexSet()
        updatedIndexes = IndexSet()
        movedIndexes = Set<TrackerCategoryStoreUpdate.Move>()
    }
    
    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>)
    {
        delegate?.store(
            self,
            didUpdate: TrackerCategoryStoreUpdate(
                insertedIndexes: insertedIndexes!,
                deletedIndexes: deletedIndexes!,
                updatedIndexes: updatedIndexes!,
                movedIndexes: movedIndexes!
            )
        )
        insertedIndexes = nil
        deletedIndexes = nil
        updatedIndexes = nil
        movedIndexes = nil
    }
    
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?
    ) {
        switch type {
        case .insert:
            guard let indexPath = newIndexPath else { fatalError() }
            insertedIndexes?.insert(indexPath.item)
        case .delete:
            guard let indexPath = indexPath else { fatalError() }
            deletedIndexes?.insert(indexPath.item)
        case .update:
            guard let indexPath = indexPath else { fatalError() }
            updatedIndexes?.insert(indexPath.item)
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else { fatalError() }
            movedIndexes?.insert(.init(oldIndex: oldIndexPath.item, newIndex: newIndexPath.item))
        @unknown default:
            fatalError()
        }
    }
}
