
struct TodayForecastBody: Codable{
    
    let currentWeather: CurrentWeather
    let hourly: Hourly?
    let hourlyUnits: HourlyUnits
    let latitude: Float
    let longitude: Float
    let timezone: String
    let weathercode: Int
}

struct CurrentWeather: Codable{
    
    let temperature: Float
    let time: String
    let weathercode: Int
    let date: String
    let image: Int
}

struct Hourly: Codable{
    
    let rain: [Double]
    let snowfall: [Double]
    let cloudcoverMid: [Double]
    // Temperature
    let temperature2m: [Double]
    // Humidity
    let relativehumidity2m: [Double]
    let time: [String]
    let weathercode: [Int]
    let precipitation: [Double]
}

struct HourlyUnits: Codable{
    
    let rain: String
    let showers: String
    let snowfall: String
    // Temperature
    let temperature2m: String
    // Humidity
    let relativehumidity2m: String
    let timex: String
}
