
protocol GetCoordByGeoUseCaseProtocol {
    
    func execute(city: String) async throws -> Response<LocationAndCoord>
}
