import Foundation
import UIKit

func stringRes(_ resource: String) -> String {
    NSLocalizedString(resource, comment: String.empty)
}

func getDefaultURIComponents(host: String, path: String) -> URLComponents {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path
    return components
}

extension LocationData {
    
    func convertToLocationItemView() -> LocationItemView {
        return LocationItemView(
            location: self.location ?? String.empty,
            isSelected: true,
            temperature: self.temperature ?? String.empty,
            temperatureRange: self.temperatureRange ?? String.empty,
            weatherIcon: UIImage(named: self.weatherIcon ?? "ic_sky_rainy_light")!
        )
    }
}

extension CALayer {

    func setCorners(radis radius: CGFloat, shadowPath: UIBezierPath) {
        self.backgroundColor = UIColor(resource: .container).cgColor
        self.masksToBounds = false
        self.shadowColor = UIColor.black.cgColor.copy(alpha: 0.1)
        self.shadowOffset = CGSize(width: 0, height: 3);
        self.shadowOpacity = 0.3
        self.borderColor = UIColor.clear.cgColor
        self.cornerRadius = radius
        self.shadowPath = shadowPath.cgPath
    }
}
