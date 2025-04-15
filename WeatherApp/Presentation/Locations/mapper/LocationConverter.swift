import UIKit

extension Location {
    
    func convertToLocationItemView() -> LocationItemView {
        return LocationItemView(
            location: self.location,
            isSelected: self.isSelected,
            temperature: self.temperature ?? String.empty,
            temperatureRange: self.temperatureRange ?? String.empty,
            weatherIcon: UIImage(named: self.weatherIcon ?? "ic_sky_rainy_light")!
        )
    }
}
