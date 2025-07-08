
protocol GetLocationByCoordUseCaseProtocol {
    
    func execute(locationName: String?, lat: Double, long: Double) async -> Response<LocationData>
}
