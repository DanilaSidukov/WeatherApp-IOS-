
protocol GetCoordByGeoUseCaseProtocol {
    
    func execute(city: String) async -> Response<LocationAndCoord>
}
