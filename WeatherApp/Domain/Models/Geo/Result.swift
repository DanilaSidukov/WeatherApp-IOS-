
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

struct Address: Codable {
    
    let country: String?
    let countryCode: String?
    let countryCodeISO3: String?
    // District
    let countrySecondarySubdivision: String?
    let countrySubdivision: String?
    // TeritaryDistrict
    let countryTertiarySubdivision: String?
    let freeformAddress: String?
    let localName: String?
    // City
    let municipality: String?
    let postalCode: String?
    let streetName: String?
    // Town
    let municipalitySubdivision: String?
}
