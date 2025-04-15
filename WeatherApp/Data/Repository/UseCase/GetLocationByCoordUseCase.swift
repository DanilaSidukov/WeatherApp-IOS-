 
class GetLocationByCoordUseCase: GetLocationByCoordUseCaseProtocol {
    
    init() {
        
    }
    
    func execute(locationName: String?, lat: Double, long: Double) async throws -> LocationData {
        return try await LocationRepository.shared.getLocationData(locationName: locationName, lat: lat, long: long)
    }
}
