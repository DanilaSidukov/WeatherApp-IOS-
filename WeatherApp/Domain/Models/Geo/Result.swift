
struct Result: Codable {
    let address: Address?
    let entityType: String?
    let id: String?
    let position: Position?
    let score: Float?
    let resultType: String? // Change to "type" to avoid conflicts
    
    enum CodingKeys: String, CodingKey {
        case address, entityType, id, position, score
        case resultType = "type"
    }
}
