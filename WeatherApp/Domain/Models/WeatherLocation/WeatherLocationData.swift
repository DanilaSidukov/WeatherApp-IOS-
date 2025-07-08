import Foundation

struct LocationWeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let generationtime_ms: Double?
    let utc_offset_seconds: Int?
    let timezone: String?
    let timezone_abbreviation: String?
    let elevation: Int?
    let current_units: CurrentUnits?
    let current: Current?
    let daily_units: DailyUnits?
    let daily: Daily?
}

struct CurrentUnits: Codable {
    let time: String?
    let interval: String?
    let temperature2m: String?
    let rain: String?
    let snowfall: String?
    let cloudCover: String?
    let precipitation: String?
}

struct Daily: Codable {
    let time: [String]?
    let temperature_2m_min: [Double]?
    let temperature_2m_max: [Double]?
}

struct DailyUnits: Codable {
    let time: String?
    let temperature_2m_min: String?
    let temperature_2m_max: String?
}
