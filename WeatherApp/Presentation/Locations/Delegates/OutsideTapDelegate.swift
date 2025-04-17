import UIKit

protocol OutsideTapDelegate {
    
    func onClick(alert: UIAlertController)
}

extension LocationsViewController: OutsideTapDelegate {
    
    func onClick(alert: UIAlertController) {
        self.present(alert, animated: true) {
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector (self.onOutsideClick)
                )
            )
        }
    }
    
    @objc func onOutsideClick() {
        self.dismiss(animated: true, completion: nil)
    }
}
