
struct LocationScreenState {
    
    var locations: [Location] = []
}

extension LocationScreenState {
    
    init(
        locations: [Location],
        forCopyInit: Void? = nil
    ) {
        self.locations = locations
    }
    
    func copy(locations: [Location]? = nil) -> LocationScreenState {
        LocationScreenState(
            locations: locations ?? self.locations
        )
    }
}
