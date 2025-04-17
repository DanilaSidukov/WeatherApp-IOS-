import UIKit

extension LocationsViewController: TextFieldAlertDelegate {
    
    func onTextInput(text: String) {
        getLocation(city: text)
    }
    
    private func getLocation(city: String) {
        if (!city.trimmingCharacters(in: .whitespaces).isEmpty) {
            Task {
                try await locationsViewModel.addLocation(city: city)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
