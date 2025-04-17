import Foundation
import UIKit

extension LocationsViewController: DeleteAlertDelegate {
    
    func onPositiveClick(press: CGPoint) {
        if let indextPath = self.collectionView.indexPathForItem(at: press) {
            self.locationsViewModel.deleteLocation(at: indextPath.item)
            self.collectionView.performBatchUpdates({
                self.collectionView.deleteItems(at: [indextPath])
            }, completion: nil)
        }
    }
    
    func onNegativeClick() -> Void {
        
    }
}
