import Foundation

protocol EventModelProtocol {
    var model: EventModel { get }
    func updateModel()
}

struct EventSectionModel: Hashable {
    let list: [String]
    let textField: [String]
    let emoji: [String]
    let color: [String]
}

struct EventModel {
    let title: String
    let model: EventSectionModel
}
