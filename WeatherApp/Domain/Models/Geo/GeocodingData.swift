
struct GeocodingData: Codable {
    
    let results: [Result]?
    let summary: Summary?
}

struct Summary: Codable {
    
    let fuzzyLevel: Int?
    let numResults: Int?
    let offset: Int?
    let query: String?
    let queryTime: Int?
    let queryType: String?
    let totalResults: Int?
}
