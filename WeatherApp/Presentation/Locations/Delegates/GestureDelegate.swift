import UIKit

extension LocationsViewController: UIGestureRecognizerDelegate {
    
    func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(onLocationLongPress(gestureRecogizer: )))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionView.addGestureRecognizer(longPressedGesture)
    }
    
    @objc private func onLocationLongPress(gestureRecogizer: UILongPressGestureRecognizer) {
        if (gestureRecogizer.state != .began) {
            return
        }
        let press = gestureRecogizer.location(in: self.collectionView)
        let deleteAlert = DeleteAlert(delegate: self,press: press)
        self.present(deleteAlert, animated: true, completion: nil)
    }
}
