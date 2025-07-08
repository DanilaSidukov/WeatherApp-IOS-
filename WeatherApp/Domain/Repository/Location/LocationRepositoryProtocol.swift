
protocol LocationRepositoryProtocol {
    
    func getLocationCoord(city: String) async throws -> Response<LocationAndCoord>
    
    func getLocationData(locationName: String?, lat: Double, long: Double) async throws -> Response<LocationData>
}
