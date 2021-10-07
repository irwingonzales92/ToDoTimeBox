//
//  LocalSearchViewData.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 8/14/21.
//

import Foundation
import MapKit
import Combine
import CoreLocation

struct LocalSearchViewData: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var logitude: CLLocationDegrees
    var latitude: CLLocationDegrees
    
    init(mapItem: MKMapItem) {
        self.title = mapItem.name ?? ""
        self.subtitle = mapItem.placemark.title ?? ""
        self.latitude = mapItem.placemark.location?.coordinate.latitude ?? 0.0
        self.logitude = mapItem.placemark.location?.coordinate.longitude ?? 0.0
    }
}
