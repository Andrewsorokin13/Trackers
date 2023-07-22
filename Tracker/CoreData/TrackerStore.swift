import Foundation
import CoreData


final class TrackerStore: NSObject {
    
    //MARK: - Static property
    static let shared = TrackerStore()
    
    //MARK: - Private property
    private let context: NSManagedObjectContext
    private var fetchedResultsController: NSFetchedResultsController<TrackerCoreData>!
    private let convertToSchedule = ConvertToScheduleCoreData.shared
    private let trackerStoreCategory = TrackerCategoryStore.shared
    private let fetchKey = "nameTracker"
    
    //MARK: - Init
    convenience override init() {
        let context = CoreDataStack.shared.context
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()
        
        let fetchRequest = TrackerCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: fetchKey, ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultsController = controller
        try? controller.performFetch()
    }
    
    //MARK: - Method
    func addNewTracker(_ tracker: Tracker, with category: TrackerCategory) throws {
        let getCategory = try trackerStoreCategory.getCategoryCoreData(category.header)
        if getCategory.isEmpty {
            addNewTrackerAndCategory(tracker, header: category.header)
        } else {
            guard let category = getCategory.first else { return }
            addTrackerForCategory(tracker, category: category)
        }
    }
    
    //MARK: - Private method
    private func addTrackerForCategory(_ tracker: Tracker, category: CategoryTrackerCoreData) {
        let newTracker = TrackerCoreData(context: context)
        newTracker.nameTracker = tracker.title
        newTracker.emoji = tracker.emoji
        newTracker.trakerID = tracker.trackerID
        newTracker.color = tracker.color
        newTracker.schedule = convertToSchedule.weekdayConvertToString(from: tracker.schedule!)
        category.addToTracker(newTracker)
        CoreDataStack.shared.saveContext(context: context)
        try? fetchedResultsController.performFetch()
    }
    
    private func addNewTrackerAndCategory(_ tracker: Tracker, header: String) {
        let trackerCoreData = TrackerCoreData(context: context)
        let trackerCategoryCoreData = CategoryTrackerCoreData(context: context)
        trackerCoreData.nameTracker = tracker.title
        trackerCoreData.emoji = tracker.emoji
        trackerCoreData.trakerID = tracker.trackerID
        trackerCoreData.color = tracker.color
        trackerCoreData.schedule = convertToSchedule.weekdayConvertToString(from: tracker.schedule!)
        trackerCategoryCoreData.header = header
        trackerCategoryCoreData.tracker = NSSet(object: trackerCoreData)
        trackerCoreData.category = trackerCategoryCoreData
        CoreDataStack.shared.saveContext(context: context)
        try? fetchedResultsController.performFetch()
    }
}
