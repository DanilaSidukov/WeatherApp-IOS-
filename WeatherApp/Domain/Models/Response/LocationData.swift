
struct LocationData {
    let location: String?
    let temperature: String?
    let temperatureRange: String?
    let weatherIcon: String?
    let latitude: Double
    let longitude: Double
    
    init(
        location: String? = nil,
        temperature: String? = nil,
        temperatureRange: String? = nil,
        weatherIcon: String? = nil,
        longitude: Double = 0.0,
        latitude: Double = 0.0
    ) {
        self.location = location
        self.temperature = temperature
        self.temperatureRange = temperatureRange
        self.weatherIcon = weatherIcon
        self.longitude = longitude
        self.latitude = latitude
    }
}
