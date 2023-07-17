
import UIKit
import CoreData

enum TrackerRecordStoreError: Error {
    case decodingError(String)
}

final class TrackerRecordStore: NSObject {
    
    //MARK: - Static property
    static let shared = TrackerRecordStore()
    
    //MARK: - Private property
    private let colorAndDayMarshalling = ConvertToScheduleCoreData.shared
    private let context: NSManagedObjectContext
    private let trackerRecordEntityName = "RecordTrackerCoreData"
    private let fetchKey = "date"
    private var fetchedResultsController: NSFetchedResultsController<RecordTrackerCoreData>!
    
    //MARK: - Init
    convenience override init() {
        let context = CoreDataStack.shared.context
        self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()
        
        let fetchRequest = RecordTrackerCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: fetchKey, ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultsController = controller
        try? controller.performFetch()
    }
    
    //MARK: - Method
    func addNewRecord(_ id: UUID, date: Date) throws {
        let record = RecordTrackerCoreData(context: context)
        record.trakerID = id
        record.date = date
        CoreDataStack.shared.saveContext(context: context)
        try fetchedResultsController.performFetch()
    }
    
    func getRecord() throws -> [TrackerRecord] {
        guard let recordCoreData = fetchedResultsController.fetchedObjects,
              let record = try? recordCoreData.map({
                  try self.convertRecord(recordCoreData: $0)
              })
        else {
            throw TrackerRecordStoreError.decodingError("Invalid Record")
        }
        return record
    }
    
    
    
    func getRecordAtID(trackerID: UUID) throws -> TrackerRecord {
        let request = NSFetchRequest<RecordTrackerCoreData>(entityName: trackerRecordEntityName)
        request.predicate = NSPredicate(format: " %K == %@", #keyPath(RecordTrackerCoreData.trakerID), trackerID as CVarArg)
        guard
            let record = try? context.fetch(request).first,
            let trakerID = record.trakerID,
            let date = record.date
        else {
            throw TrackerRecordStoreError.decodingError("InvalidRecord")
        }
        return TrackerRecord(id: trakerID, date: date)
    }
    
    func deleteRecord(_ id: UUID) throws {
        let request = NSFetchRequest<RecordTrackerCoreData>(entityName: trackerRecordEntityName)
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: " %K == %@", #keyPath(RecordTrackerCoreData.trakerID), id as CVarArg)
        guard let record = try? context.fetch(request).first else { return }
        context.delete(record)
        CoreDataStack.shared.saveContext(context: context)
        try fetchedResultsController.performFetch()
    }
    
    //MARK: - Private method
    private func convertRecord(recordCoreData: RecordTrackerCoreData) throws -> TrackerRecord {
        guard let id = recordCoreData.trakerID else {
            throw TrackerRecordStoreError.decodingError("Invalid ID")
            
        }
        guard let date = recordCoreData.date else {
            throw TrackerRecordStoreError.decodingError("Invalid Date")
        }
        return TrackerRecord(id: id, date: date)
    }
}
