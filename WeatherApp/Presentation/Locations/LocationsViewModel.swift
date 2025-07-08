import SwiftyBeaver
import Foundation

final class LocationsViewModel {
    
    private let getCoordByGeoUseCase: GetCoordByGeoUseCase
    private let getLocationByCoordUseCase: GetLocationByCoordUseCase
    
    var locationsScreenState: LocationScreenState = LocationScreenState()
    
    var showError: ((String) -> ())?
    
    init(getCoordByGeoUseCase: GetCoordByGeoUseCase, getLocationByCoordUseCase: GetLocationByCoordUseCase) {
        self.getCoordByGeoUseCase = getCoordByGeoUseCase
        self.getLocationByCoordUseCase = getLocationByCoordUseCase
        loadLocations()
        Task {
            await self.updateLocations()
        }
    }
    
    private func loadLocations() {
        WeatherCoreDataService.shared.getAllLocations()
        let locations = WeatherCoreDataService.shared.locations
        setState { old in
            old.copy(locations: locations)
        }
    }
    
    func getLocation(at index: Int) -> Location {
        return locationsScreenState.locations[index]
    }
    
    func getLocationsCount() -> Int {
        return locationsScreenState.locations.count
    }
    
    func addLocation(city: String) async throws {
        let locationAndCoord = await self.getCoordByGeoUseCase.execute(city: city)
        switch locationAndCoord {
            case .success(data: let data):
                await addLocationByCoord(locationAndCoord: data)
            case .error(message: let message):
                showError?(message)
            }
    }
    
    private func addLocationByCoord(locationAndCoord: LocationAndCoord) async {
        let response = await self.getLocationByCoordUseCase.execute(
            locationName: locationAndCoord.locationName,
            lat: locationAndCoord.latitude,
            long: locationAndCoord.longitude
        )
        switch response {
            case .success(data: let data):
                addLocationToDataBase(locationData: data)
            case .error(message: let message):
                showError?(message)
        }
    }
    
    private func addLocationToDataBase(locationData: LocationData) {
        do {
            try WeatherCoreDataService.shared.addLocation(locationData: locationData)
            let locations = WeatherCoreDataService.shared.locations
            setState { old in
                old.copy(locations: locations)
            }
        } catch {
            showError?(stringRes("something_wrong"))
        }
    }
    
    private func updateLocation(location: Location) async {
        let response = await self.getLocationByCoordUseCase.execute(
            locationName: location.location,
            lat: location.latitude,
            long: location.longitude
        )
        switch response {
            case .success(data: let data):
                WeatherCoreDataService.shared.updateLocation(locationData: data)
            case .error(message: let message):
                showError?(message)
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
    
    func updateLocations() async {
        for location in locationsScreenState.locations {
            await updateLocation(location: location)
        }
        loadLocations()
    }
    
    private func setState(update: (LocationScreenState) -> LocationScreenState) {
        self.locationsScreenState = update(self.locationsScreenState)
    }
}
