import Foundation

@MainActor
final class WeatherViewModel {
    
    var onStateChange: ((WeatherState) -> Void)?
    
    private let getHourlyWeatherUseCase: GetHourlyWeatherUseCaseProtocol
    
    var weatherState = WeatherState()
    
    init(
        getHourlyWeatherUseCase: GetHourlyWeatherUseCaseProtocol,
        locationData: LocationData
    ) {
        self.getHourlyWeatherUseCase = getHourlyWeatherUseCase
        setState { old in
            old.copy(locationData: locationData)
        }
        if (locationData.location != nil) {
            loadWeatherData()
        }
    }
    
    private func loadWeatherData() {
        Task { [weak self] in
            guard let self else { return }
            let locationData = self.weatherState.locationData
            let response = await self.getHourlyWeatherUseCase.excecute(
                lat: locationData.latitude,
                long: locationData.longitude
            )
            DispatchQueue.main.async {
                switch response {
                case .success(data: let list):
                    self.setState { old in
                        old.copy(hourlyState: HourlyState.data(list))
                    }
                case .error(message: let message):
                    self.setState { old in
                        old.copy(hourlyState: HourlyState.error(message))
                    }
                }
            }
        }
    }
    
    private func setState(update: (WeatherState) -> WeatherState) {
        let newState = update(self.weatherState)
        self.weatherState = newState
        self.onStateChange?(newState)
    }
}
