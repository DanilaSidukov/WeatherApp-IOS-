import Foundation
import OSLog

class GetCoordByGeoUseCase: GetCoordByGeoUseCaseProtocol {
    
    init() {
        
    }
    
    func execute(city: String) async -> Response<LocationAndCoord> {
        return await LocationRepository.shared.getLocationCoord(city: city)
    }
}

