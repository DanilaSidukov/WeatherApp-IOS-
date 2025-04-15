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
