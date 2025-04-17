//
//  Location+CoreDataProperties.swift
//  Domain
//
//  Created by Danila Sidukov on 18.03.2025.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged var isSelected: Bool
    @NSManaged var location: String
    @NSManaged var temperature: String?
    @NSManaged var temperatureRange: String?
    @NSManaged var weatherIcon: String?
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double

}

extension Location : Identifiable {

}
