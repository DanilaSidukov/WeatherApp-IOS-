
struct LocationData {
    let location: String?
    let temperature: String?
    let temperatureRange: String?
    let weatherIcon: String?
    
    init(
        location: String? = nil,
        temperature: String? = nil,
        temperatureRange: String? = nil,
        weatherIcon: String? = nil
    ) {
        self.location = location
        self.temperature = temperature
        self.temperatureRange = temperatureRange
        self.weatherIcon = weatherIcon
    }
}
