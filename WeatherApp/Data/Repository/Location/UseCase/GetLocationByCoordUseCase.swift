 
class GetLocationByCoordUseCase: GetLocationByCoordUseCaseProtocol {
    
    init() {
        
    }
    
    func execute(locationName: String?, lat: Double, long: Double) async -> Response<LocationData> {
        return await LocationRepository.shared.getLocationData(locationName: locationName, lat: lat, long: long)
    }
}
