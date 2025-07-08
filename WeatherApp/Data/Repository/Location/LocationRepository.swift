import Foundation
import OSLog

class LocationRepository {
    
    private let logger = Logger(subsystem: "com.diphrogram.weatherapp", category: "LocationRepository")
    
    static let shared = LocationRepository()
    
    private let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
    }
}

extension LocationRepository: LocationRepositoryProtocol {
    
    // MARK: get location coordinates
    func getLocationCoord(city: String) async -> Response<LocationAndCoord> {
        
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? city
        
        // url example = https://api.tomtom.com/search/2/geocode/%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0.json?view=Unified&key=sHOgdqa34WjcDtweEdBGyhe9FA4WzL1i
        let endpoint = "\(API.GEO)/search/2/geocode/\(encodedCity).json?view=Unified&key=sHOgdqa34WjcDtweEdBGyhe9FA4WzL1i"
        
        guard let url = URL(string: endpoint) else {
            logger.error("invalidURL")
            return .error(message: stringRes("location_not_found"))
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == NetworkCode.success else {
                logger.error("invalidResponse: \((response as? HTTPURLResponse))")
                return .error(message: stringRes("error_get_data"))
            }
            
            let decodedData = try decoder.decode(GeocodingData.self, from: data)
            guard let result = decodedData.results?.first else {
                logger.error("invalidData in result")
                return .error(message: stringRes("error_get_data"))
            }
            if let lat = result.position?.lat, let lon = result.position?.lon {
                let locationAndCoord = LocationAndCoord(
                    locationName: result.address?.municipality,
                    latitude: lat,
                    longitude: lon
                )
                return .success(data: locationAndCoord)
            } else {
                return .error(message: stringRes("something_wrong"))
            }
        } catch {
            logger.error("invalidData catched \(error)")
            return .error(message: stringRes("something_wrong"))
        }
    }
    
    // MARK: get location data
    func getLocationData(locationName: String?, lat: Double, long: Double) async -> Response<LocationData> {
        // url example = https://open-meteo.com/en/docs?timezone=Europe%2FMoscow&current=temperature_2m,rain,snowfall,cloud_cover,precipitation&daily=temperature_2m_min,temperature_2m_max
        
        var components = getDefaultURIComponents(host: "api.open-meteo.com", path: "/v1/forecast")
        
        components.queryItems = [
            URLQueryItem(name: "latitude", value: "\(lat)"),
            URLQueryItem(name: "longitude", value: "\(long)"),
            URLQueryItem(name: "daily", value: "temperature_2m_min,temperature_2m_max"),
            URLQueryItem(name: "current", value: "temperature_2m,rain,snowfall,cloud_cover,precipitation"),
            URLQueryItem(name: "timezone", value: "Europe/Moscow"),
            URLQueryItem(name: "forecast_days", value: "1")
        ]
        
        guard let url = components.url else {
            return .error(message: stringRes("something_wrong"))
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == NetworkCode.success else {
                return .error(message: stringRes("error_get_data"))
            }
            
            let decodedData = try decoder.decode(LocationWeatherData.self, from: data)
            if let current = decodedData.current, let daily = decodedData.daily {
                let weatherIcon = getWeatherIcon(
                    rain: current.rain ?? 0.0,
                    snowfall: current.snowfall ?? 0.0,
                    cloudCover: current.cloud_cover ?? 0.0,
                    precipitation: current.precipitation ?? 0.0
                )
 
                let minTemp = daily.temperature_2m_min?.first
                let maxTemp = daily.temperature_2m_max?.first
                let currentTemp = getCurrentTemp(temp: current.temperature_2m)
                let currentTempRange = getCurrentTempRange(min: minTemp, max: maxTemp)

                let locationData = LocationData(
                    location: locationName,
                    temperature: currentTemp,
                    temperatureRange: currentTempRange,
                    weatherIcon: weatherIcon,
                    longitude: long,
                    latitude: lat
                )
                logger.info("data loader for: \(locationName ?? "Error")")
                return .success(data: locationData)
            } else {
                logger.error("getLocationDataError while decode JSON")
                return .error(message: stringRes("error_get_data"))
            }
        } catch {
            return .error(message: stringRes("something_wrong"))
        }
    }
}
