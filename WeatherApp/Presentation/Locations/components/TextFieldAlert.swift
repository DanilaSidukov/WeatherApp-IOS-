import Foundation
import SwiftUI

final class TextFieldAlert: UIAlertController {
    
    convenience init(didTextInput: ((String?) -> Void)? = nil) {
        
        self.init(
            title: stringRes("add_location"),
            message: nil,
            preferredStyle: UIAlertController.Style.alert
        )
        self.addAction(
            UIAlertAction(title: stringRes("add"), style: .default) { _ in
                if let text = self.textFields!.first?.text {
                    didTextInput?(text)
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
