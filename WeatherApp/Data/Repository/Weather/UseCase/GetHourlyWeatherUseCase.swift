
final class GetHourlyWeatherUseCase: GetHourlyWeatherUseCaseProtocol {
    
    init() {
        
    }
    
    func excecute(lat: Double, long: Double) async -> Response<Array<HourlyWeather>> {
        let repository = WeatherRepository.shared
        return await repository.getHourlyWeather(lat: lat, long: long)
    }
}
