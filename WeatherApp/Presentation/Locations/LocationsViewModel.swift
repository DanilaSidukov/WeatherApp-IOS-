
final class LocationsViewModel {
    
    private let getCoordByGeoUseCase: GetCoordByGeoUseCase
    private let getLocationByCoordUseCase: GetLocationByCoordUseCase
    
    var locationsScreenState: LocationScreenState = LocationScreenState()
    
    init(getCoordByGeoUseCase: GetCoordByGeoUseCase, getLocationByCoordUseCase: GetLocationByCoordUseCase) {
        self.getCoordByGeoUseCase = getCoordByGeoUseCase
        self.getLocationByCoordUseCase = getLocationByCoordUseCase
        loadLocations()
    }
    
    func loadLocations() {
        WeatherCoreDataService.shared.getAllLocations()
        let locations = WeatherCoreDataService.shared.locations
        setState { old in
            old.copy(locations: locations)
        }
    }
    
    func getLocations() -> [Location] {
        return locationsScreenState.locations
    }
    
    func addLocation(city: String) async throws {
        let locationAndCoord = try await self.getCoordByGeoUseCase.execute(city: city)
        let response = try await self.getLocationByCoordUseCase.execute(
            locationName: locationAndCoord.locationName,
            lat: locationAndCoord.latitude,
            long: locationAndCoord.longitude
        )
        WeatherCoreDataService.shared.addLocation(locationData: response)
        let locations = WeatherCoreDataService.shared.locations
        setState { old in
            old.copy(locations: locations)
        }
    }
    
    func deleteLocation(at index: Int) {
        WeatherCoreDataService.shared.deleteLocation(at: index)
        let locations = WeatherCoreDataService.shared.locations
        setState { old in
            old.copy(locations: locations)
        }
    }
    
    func deselectPreviousLocations(except locationName: String?) {
        WeatherCoreDataService.shared.deselectPreviousLocations(except: locationName)
    }
    
    private func setState(update: (LocationScreenState) -> LocationScreenState) {
        self.locationsScreenState = update(self.locationsScreenState)
    }
}
