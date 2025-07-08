
struct WeatherState {
    
    var locationData: LocationData = LocationData()
    var hourlyList: [HourlyWeather] = []
}

extension WeatherState {
    
    init(
        locationData: LocationData,
        forCopyInit: Void? = nil,
        hourlyList: [HourlyWeather]
    ) {
        self.locationData = locationData
        self.hourlyList = hourlyList
    }
    
    func copy(
        locationData: LocationData? = nil,
        hourlyList: [HourlyWeather]? = nil
    ) -> WeatherState {
        WeatherState(
            locationData: locationData ?? self.locationData,
            hourlyList: hourlyList ?? self.hourlyList
        )
    }
}
