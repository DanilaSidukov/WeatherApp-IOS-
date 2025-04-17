import Foundation
import SwiftUI

protocol TextFieldAlertDelegate {
    
    func onTextInput(text: String)
}

final class TextFieldAlert: UIAlertController {
    
    convenience init(
        delegate: TextFieldAlertDelegate,
    ) {
        self.init(
            title: stringRes("add_location"),
            message: nil,
            preferredStyle: UIAlertController.Style.alert
        )
        self.addAction(
            UIAlertAction(title: stringRes("add"), style: .default) { _ in
                if let text = self.textFields!.first?.text {
                    delegate.onTextInput(text: text)
                }
            }
        )
        self.addTextField(
            configurationHandler: {(textField: UITextField!) in
                textField.placeholder = stringRes("input_location_name")
            }
        )
    }
}
