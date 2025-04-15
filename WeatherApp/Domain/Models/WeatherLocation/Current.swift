
struct Current: Codable {
    let time: String?
    let interval: Int?
    let temperature_2m: Double?
    let rain: Double?
    let snowfall: Double?
    let cloud_cover: Double?
    let precipitation: Double?
}

func getWeatherIcon(rain: Double, snowfall: Double, cloudCover: Double, precipitation: Double) -> String {
    let weatherValues = [
        "rain": rain,
        "snowfall": snowfall,
        "cloud_cover": cloudCover
    ].compactMapValues { $0 }
    
    if (precipitation < 3) {
        return "ic_sun"
    } else {
        let mostSignificantValue = weatherValues.max(by: { $0.value < $1.value })
        switch (mostSignificantValue?.key ?? String.empty) {
            case "snowfall":
                return "ic_snowflake"
                
            case "cloud_cover":
                return "ic_sky_dark"
                
            case "rain":
                return "ic_sky_rainy_dark"
                
            default:
                return "ic_sun"
            }
    }
}
