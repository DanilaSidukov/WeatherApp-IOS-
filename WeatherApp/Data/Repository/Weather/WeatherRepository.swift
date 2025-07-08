import Foundation
import OSLog

class WeatherRepository {
    
    private let logger = Logger(subsystem: "com.example.WeatherApp", category: "WeatherRepository")
    
    static let shared = WeatherRepository()
    
    private let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
    }
}

extension WeatherRepository: WeatherRepositoryProtocol {
    
    func getHourlyWeather(lat: Double, long: Double) async -> Response<Array<HourlyWeather>> {
        
        //Example - https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m,rain,snowfall,cloud_cover,precipitation&timezone=Europe%2FMoscow&forecast_days=1
        var components = getDefaultURIComponents(host: "api.open-meteo.com", path: "/v1/forecast")
        components.queryItems = [
            URLQueryItem(name: "latitude", value: "\(lat)"),
            URLQueryItem(name: "longitude", value: "\(long)"),
            URLQueryItem(name: "hourly", value: "temperature_2m,rain,snowfall,cloud_cover,precipitation"),
            URLQueryItem(name: "timezone", value: "Europe/Moscow"),
            URLQueryItem(name: "forecast_days", value: "1")
        ]
        
        guard let url = components.url else {
            return .error(message: stringRes("something_wrong"))
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == NetworkCode.success else {
                return .error(message: stringRes("error_get_data"))
            }
            logger.info("before \(response)")
            let decodedData = try decoder.decode(HourlyWeatherResponse.self, from: data)
            logger.info("loaded data \(data)")
            if let hourly = decodedData.hourly {
                var hourlyList = [HourlyWeather]()
                for index in 0...hourly.precipitation.count - 1 {
                    let icon = getWeatherIcon(
                        rain: hourly.rain[index],
                        snowfall: hourly.snowfall[index],
                        cloudCover: hourly.cloudCover[index],
                        precipitation: hourly.precipitation[index]
                    )
                    hourlyList.append(
                        HourlyWeather(
                            time: getHour(date: hourly.time[index]),
                            icon: icon,
                            temperature: Int(hourly.temperature2m[index])
                        )
                    )
                }
                return .success(data: hourlyList)
            } else {
                logger.error("getLocationDataError while decode JSON")
                return .error(message: stringRes("error_get_data"))
            }
        } catch {
            logger.error(" 123 \(error.localizedDescription)")
            return .error(message: stringRes("error_get_data"))
        }
    }
}

private func getHour(date: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
    inputFormatter.locale = Locale(identifier: "en_US_POSIX")
    let date = inputFormatter.date(from: date)
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "HH"
    let hourString = outputFormatter.string(from: date!)
    return hourString
}
