import UIKit

class InfoDialog: UIAlertController {
    
    convenience init(
        title: String = stringRes("error"),
        message: String,
        delegate: OutsideTapDelegate
    ) {
        self.init(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        self.addAction(
            UIAlertAction(
                title: stringRes("ok"), style: .default
            )
        )
        delegate.onClick(alert: self)
    }
}
