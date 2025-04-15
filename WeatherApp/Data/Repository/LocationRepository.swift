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
    
    func getLocationCoord(city: String) async throws -> LocationAndCoord {
        
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? city
        
        // url example = https://api.tomtom.com/search/2/geocode/%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0.json?view=Unified&key=sHOgdqa34WjcDtweEdBGyhe9FA4WzL1i
        let endpoint = "\(API.GEO)/search/2/geocode/\(encodedCity).json?view=Unified&key=sHOgdqa34WjcDtweEdBGyhe9FA4WzL1i"
        
        guard let url = URL(string: endpoint) else {
            logger.error("invalidURL")
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == NetworkCode.success else {
            logger.error("invalidResponse: \((response as? HTTPURLResponse))")
            throw NetworkError.invalidResponse
        }
        
        do {
            let decodedData = try decoder.decode(GeocodingData.self, from: data)
            guard let result = decodedData.results?.first else {
                logger.error("invalidData in result")
                throw NetworkError.invalidData
            }
            return if let lat = result.position?.lat, let lon = result.position?.lon {
                LocationAndCoord(
                    locationName: result.address?.municipality,
                    latitude: lat,
                    longitude: lon
                )
            } else {
                throw NetworkError.invalidData
            }
        } catch {
            logger.error("invalidData catched \(error)")
            throw NetworkError.invalidData
        }
    }
    
    func getLocationData(locationName: String?, lat: Double, long: Double) async throws -> LocationData {
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
            throw URLError(.badURL)
        }
        
        logger.info("url path: \(url)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == NetworkCode.success else {
            logger.error("invalidReponse: \((response as? HTTPURLResponse))")
            throw NetworkError.invalidResponse
        }
        
        logger.info("response: \(response) and data: \(String(data: data, encoding: .utf8) ?? "")")
        
        do {
            let decodedData = try decoder.decode(LocationWeatherData.self, from: data)
            print("decoded data: \(decodedData)")
            if let current = decodedData.current, let daily = decodedData.daily {
                let weatherIcon = getWeatherIcon(rain: current.rain ?? 0.0, snowfall: current.snowfall ?? 0.0, cloudCover: current.cloud_cover ?? 0.0, precipitation: current.precipitation ?? 0.0)
                
                // Safely access the temperature ranges
                let minTemp = daily.temperature_2m_min?.first
                let maxTemp = daily.temperature_2m_max?.first
                let currentTemp = getCurrentTemp(temp: current.temperature_2m)
                let currentTempRange = getCurrentTempRange(min: minTemp, max: maxTemp)

                let locationData = LocationData(
                    location: locationName,
                    temperature: currentTemp,
                    temperatureRange: currentTempRange,
                    weatherIcon: weatherIcon
                )
                
                return locationData
            } else {
                logger.error("getLocationDataError while decode JSON")
                throw NetworkError.invalidData
            }
            
        } catch {
            logger.error("getLocationDataError: \(error)")
            throw NetworkError.invalidData
        }
    }
}

private func getCurrentTemp(temp: Double?) -> String {
    var currentTempString: String
    
    if (temp != nil) {
        let tempInt = Int(temp!)
        currentTempString = String(tempInt)
    } else {
        currentTempString = "N/A"
    }
    
    return currentTempString
}

private func getCurrentTempRange(min: Double?, max: Double?) -> String {
    var currentTempRangeString: String
    
    if (min != nil && max != nil) {
        let minInt = Int(min!)
        let maxInt = Int(max!)
        currentTempRangeString = "\(minInt) - \(maxInt)"
    } else {
        currentTempRangeString = "N/A"
    }
    return currentTempRangeString
}
