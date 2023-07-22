import Foundation


enum CollectionViewSection: Int, CaseIterable {
    case textField
    case list
    case emoji
    case color
    
    var columnCount: Int {
        switch self {
        case .textField: return 1
        case .list: return 1
        case .emoji: return 6
        case .color: return 6
        }
    }
    
    var nameSection: String? {
        switch self {
        case .textField: return nil
        case .list: return nil
        case .emoji: return "Emoji"
        case .color: return "Цвет"
        }
    }
}

