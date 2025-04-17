import Foundation
import OSLog

class GetCoordByGeoUseCase: GetCoordByGeoUseCaseProtocol {
    
    init() {
        
    }
    
    func execute(city: String) async throws -> Response<LocationAndCoord> {
        return try await LocationRepository.shared.getLocationCoord(city: city)
    }
}

