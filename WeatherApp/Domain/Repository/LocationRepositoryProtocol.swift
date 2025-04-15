
protocol LocationRepositoryProtocol {
    
    func getLocationCoord(city: String) async throws -> LocationAndCoord
    
    func getLocationData(locationName: String?, lat: Double, long: Double) async throws -> LocationData
}
