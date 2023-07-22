import UIKit

protocol SaveEventCollectionViewDelegate {
    func saveEmoje(indexPath: IndexPath)
    func saveColor(indexPath: IndexPath)
    func didSelectItem(_ item: IndexPath)
}

class EventCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    private var selectedRow = -1 , emojiSelectedRow  = -1
    
    //MARK: - SaveEventCollectionViewDelegate
    var delegate: SaveEventCollectionViewDelegate?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.section
        switch section {
        case 1:
            delegate?.didSelectItem(indexPath)
        case 2 :
            selectedItemEmojiCell(selectedRow: emojiSelectedRow, at: indexPath, collectionView: collectionView)
            delegate?.saveEmoje(indexPath: indexPath)
        case 3 :
            selectedItemColorCell(selectedRow: selectedRow, at: indexPath, collectionView: collectionView)
            delegate?.saveColor(indexPath: indexPath)
        default:
            return
        }
    }
    
    //MARK: - Private method
    private func selectedItemColorCell(selectedRow: Int , at indexPath: IndexPath, collectionView: UICollectionView ){
        if selectedRow == indexPath.row {
            return
        }
        if let previousCell = collectionView.cellForItem(at: IndexPath(row: selectedRow, section: indexPath.section)) as? ColorCollectionCell {
            previousCell.configDidDeSelected()
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? ColorCollectionCell {
            cell.configDidSelected()
            self.selectedRow = indexPath.row
        }
    }
    
    private func selectedItemEmojiCell(selectedRow: Int , at indexPath: IndexPath, collectionView: UICollectionView ){
        if selectedRow == indexPath.row {
            return
        }
        if let previousCell = collectionView.cellForItem(at: IndexPath(row: selectedRow, section: indexPath.section)) as? EmojiCollectionCell {
            previousCell.configDidDeSelected()
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? EmojiCollectionCell {
            cell.configDidSelected()
            self.emojiSelectedRow = indexPath.row
        }
    }
}
