//
//  MapDataManager.swift
//  LetsEat
//
//  Created by kamilcal on 25.12.2022.
//

import Foundation
import MapKit

class MapDataManager: DataManager {
    
    private var items: [RestaurantItem] = []
    var annotations: [RestaurantItem] {
        items
    }
    
    
    func fetch (completion: (_ annotations: [RestaurantItem]) -> ()) {
       let manager = RestaurantDataManager()
        manager.fetch(location: "Boston") { restaurantItems in
            self.items = restaurantItems
            completion(items)
        }
    }
    
    func initialRegion(letDelta: CLLocationDegrees, longDelta: CLLocationDegrees) -> MKCoordinateRegion {
        guard let item = items.first else {
            return MKCoordinateRegion()
        }
            let span = MKCoordinateSpan(latitudeDelta: letDelta, longitudeDelta: longDelta)
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
    
}
