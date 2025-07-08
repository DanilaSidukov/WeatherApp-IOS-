
struct WeatherState {
    
    var locationData: LocationData = LocationData()
    var hourlyState: HourlyState = HourlyState.loading
}

extension WeatherState {
    
    init(
        locationData: LocationData,
        forCopyInit: Void? = nil,
        hourlyState: HourlyState,
    ) {
        self.locationData = locationData
        self.hourlyState = hourlyState
    }
    
    func copy(
        locationData: LocationData? = nil,
        hourlyState: HourlyState? = nil
    ) -> WeatherState {
        WeatherState(
            locationData: locationData ?? self.locationData,
            hourlyState: hourlyState ?? self.hourlyState
        )
    }
}

enum HourlyState {
    case loading
    case error(String)
    case data([HourlyWeather])
}
