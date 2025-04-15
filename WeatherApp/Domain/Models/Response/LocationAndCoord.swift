
struct LocationAndCoord {
    let locationName: String?
    let latitude: Double
    let longitude: Double
    
    init(locationName: String?, latitude: Double, longitude: Double) {
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
    }
}
