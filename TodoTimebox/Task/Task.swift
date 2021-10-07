//
//  Fighter.swift
//  FightRank
//
//  Created by Irwin Gonzales on 5/30/21.
//

import Foundation
import FirebaseFirestoreSwift
import MapKit
import CoreLocation
import Combine

// Adjusting to geofencing functions

enum PreferencesKeys: String {
  case savedItems
}

class Task: NSObject, Identifiable, Codable, MKAnnotation {
    
//    enum EventType: String {
//      case onEntry = "On Entry"
//      case onExit = "On Exit"
//    }
    
    
    var eventTitle: String
    var coordinate: CLLocationCoordinate2D
    var latitude: Double
    var longitude: Double
//    var radius: CLLocationDistance
    var timeTotal: Int?
//    var eventType: EventType
    var location: String?
    
    enum CodingKeys: String, CodingKey {
        case eventTitle, timeTotal, location, coordinate
        case latitude, longitude, note
    }
    
//    func clampRadius(maxRadius: CLLocationDegrees) {
//      radius = min(radius, maxRadius)
//    }
    
    init(eventTitle: String,cooridnate: CLLocationCoordinate2D, latitude: Double, longitude: Double, timeTotal: Int, location: String) {
        self.eventTitle = eventTitle
        self.coordinate = cooridnate
        self.latitude = latitude
        self.longitude = longitude
//        self.radius = radius
        self.timeTotal = timeTotal
        self.location = location
//        self.eventType = eventType
    }
    
    required init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      latitude = try values.decode(Double.self, forKey: .latitude)
      longitude = try values.decode(Double.self, forKey: .longitude)
      coordinate = CLLocationCoordinate2DMake(latitude, longitude)
      eventTitle = try values.decode(String.self, forKey: .eventTitle)
//      radius = try values.decode(Double.self, forKey: .radius)
//      let event = try values.decode(String.self, forKey: .eventType)
//      eventType = EventType(rawValue: event) ?? .onEntry
    }

    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(coordinate.latitude, forKey: .latitude)
      try container.encode(coordinate.longitude, forKey: .longitude)
      try container.encode(eventTitle, forKey: .eventTitle)
//      try container.encode(radius, forKey: .radius)
//      try container.encode(eventType.rawValue, forKey: .eventType)
    }
}

extension Task {
  public class func allTasks() -> [Task] {
    guard let savedData = UserDefaults.standard.data(forKey: PreferencesKeys.savedItems.rawValue) else { return [] }
    let decoder = JSONDecoder()
    if let savedTasks = try? decoder.decode(Array.self, from: savedData) as [Task] {
      return savedTasks
    }
    return []
  }
}

//extension Task {
//  // Put region here
//  var region: CLCircularRegion {
//    // 1
//    let region = CLCircularRegion(
//      center: coordinate,
//      radius: radius,
//      identifier: title ?? "")
//
//    // 2
////    region.notifyOnEntry = (eventType == .onEntry)
//    region.notifyOnExit = !region.notifyOnEntry
//    return region
//  }
//}
