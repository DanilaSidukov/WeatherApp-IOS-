import Foundation
import SwiftUI

final class DeleteAlert: UIAlertController {
    
    convenience init(
        onPositiveClick: (() -> Void)? = nil,
        onNegativeClick: (() -> Void)? = nil
    ) {
        self.init(
            title: stringRes("delete_location"),
            message: nil,
            preferredStyle: UIAlertController.Style.alert
        )
        self.addAction(
            UIAlertAction(title: stringRes("yes"), style: .destructive) { _ in
                onPositiveClick?()
            }
        )
        self.addAction(
            UIAlertAction(title: stringRes("no"), style: .cancel) { _ in
                onNegativeClick?()
            }
        )
    }
}

