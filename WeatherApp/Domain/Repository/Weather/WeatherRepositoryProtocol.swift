
protocol WeatherRepositoryProtocol {
    
    func getHourlyWeather(
        lat: Double,
        long: Double
    ) async throws -> Response<Array<HourlyWeather>>
}
