import Foundation
import SwiftUI

protocol DeleteAlertDelegate {
    
    func onPositiveClick(press: CGPoint)
    
    func onNegativeClick()
}

final class DeleteAlert: UIAlertController {
    
    convenience init(
        delegate: DeleteAlertDelegate,
        press: CGPoint
    ) {
        self.init(
            title: stringRes("delete_location"),
            message: nil,
            preferredStyle: UIAlertController.Style.alert
        )
        self.addAction(
            UIAlertAction(title: stringRes("yes"), style: .destructive) { _ in
                delegate.onPositiveClick(press: press)
            }
        )
        self.addAction(
            UIAlertAction(title: stringRes("no"), style: .cancel) { _ in
                delegate.onNegativeClick()
            }
        )
    }
}

