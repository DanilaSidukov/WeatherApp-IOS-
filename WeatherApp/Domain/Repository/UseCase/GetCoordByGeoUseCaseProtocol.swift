
protocol GetCoordByGeoUseCaseProtocol {
    
    func execute(city: String) async throws -> LocationAndCoord
}
