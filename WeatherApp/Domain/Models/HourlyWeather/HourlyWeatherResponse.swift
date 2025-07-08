import Foundation

struct HourlyWeatherResponse: Codable {
    let latitude: Double
    let longitude: Double
    let generationtimeMs: Double
    let utcOffsetSeconds: Int
    let timezone: String
    let timezoneAbbreviation: String
    let elevation: Double
    let hourlyUnits: HourlyWeatherUnits
    let hourly: HourlyWeatherData?

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMs = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case hourlyUnits = "hourly_units"
        case hourly
    }
}

struct HourlyWeatherUnits: Codable {
    let time: String
    let temperature2m: String
    let rain: String
    let snowfall: String
    let cloudCover: String
    let precipitation: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2m = "temperature_2m"
        case rain
        case snowfall
        case cloudCover = "cloud_cover"
        case precipitation
    }
}

struct HourlyWeatherData: Codable {
    let time: [String]
    let temperature2m: [Double]
    let rain: [Double]
    let snowfall: [Double]
    let cloudCover: [Double]
    let precipitation: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2m = "temperature_2m"
        case rain
        case snowfall
        case cloudCover = "cloud_cover"
        case precipitation
    }
}
