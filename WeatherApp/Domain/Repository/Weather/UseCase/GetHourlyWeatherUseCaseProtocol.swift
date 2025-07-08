
protocol GetHourlyWeatherUseCaseProtocol {
    
    func excecute(lat: Double, long: Double) async -> Response<Array<HourlyWeather>>
}
