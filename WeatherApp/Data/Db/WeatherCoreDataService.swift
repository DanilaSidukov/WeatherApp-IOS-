import Foundation
import UIKit
import CoreData

final class WeatherCoreDataService {

    static let shared = WeatherCoreDataService()
    
    var locations: [Location] = []
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getAllLocations() {
        let request = Location.fetchRequest()
        if let locations = try? context.fetch(request) {
            self.locations = locations
        }
    }
    
    func addLocation(locationData: LocationData) throws {
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "location == %@", locationData.location ?? stringRes("unknown"))
        
        do {
            let existingLocations = try context.fetch(fetchRequest)
            if existingLocations.isEmpty {
                let location = Location(context: context)
                location.location = locationData.location ?? stringRes("unknown")
                location.isSelected = true
                location.temperature = locationData.temperature
                location.temperatureRange = locationData.temperatureRange
                location.weatherIcon = locationData.weatherIcon
                location.latitude = locationData.latitude
                location.longitude = locationData.longitude
                
                saveContext()
                getAllLocations()
                deselectPreviousLocations(except: location.location)
            } else {
                log.info("Location \(String(describing: locationData.location)) already exist in db")
            }
        } catch {
            log.info("Error while checking location: \(error.localizedDescription)")
        }
    }
    
    func updateLocation(locationData: LocationData) {
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "latitude == %@ AND longitude == %@",
            NSNumber(floatLiteral: locationData.latitude),
            NSNumber(floatLiteral: locationData.longitude)
        )

        do {
            if let existingLocation = try context.fetch(fetchRequest).first {
                existingLocation.temperature = locationData.temperature
                existingLocation.temperatureRange = locationData.temperatureRange
                existingLocation.weatherIcon = locationData.weatherIcon
                saveContext()
            } else {
                log.info("Location \(locationData.location ?? "Unknown") doesn't exist in DB")
            }
        } catch {
            log.info("Error while fetching location: \(error.localizedDescription)")
        }
    }
    
    func deselectPreviousLocations(except locationName: String?) {
        for location in locations {
            location.isSelected = (location.location == locationName)
        }
        saveContext()
    }
    
    func deleteLocation(at index: Int) {
        let locationToDelete = locations[index]
        context.delete(locationToDelete)
        locations.remove(at: index)
        saveContext()
    }
}
