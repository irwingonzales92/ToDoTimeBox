//
//  MapViewModel.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 7/15/21.
//

import Foundation
import MapKit
import SwiftUI
import CoreLocation

class MapViewModel:NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private var taskVM = TaskViewModel()
    
    @Published var mapView = MKMapView()
    @Published var region : MKCoordinateRegion!
    @Published var permissionDenied = false
    @Published var mapType : MKMapType = .standard
    @Published var tasks = [Task]()
    @Published var locationManager = CLLocationManager()
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // check permissions
        
        switch manager.authorizationStatus {
        case .denied:
            // alert
            permissionDenied.toggle()
        case .notDetermined:
            // requesting
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func focusLocation() {
        guard let _ = region else { return }
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func unfocus() {
        guard let _ = region else { return }
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // error
        print(error.localizedDescription)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
    
        //update map
        self.mapView.setRegion(self.region, animated: true)
        
        //smooth animations
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
    
    // MARK: Loading and saving functions
    func loadAllGeotifications() {
        tasks.removeAll()
      let allGeotifications = Task.allTasks()
      allGeotifications.forEach { taskVM.getConvertTaskToPlacemark(task: $0) }
      allGeotifications.forEach { add($0) }
    }

    func saveAllGeotifications() {
      let encoder = JSONEncoder()
      do {
        let data = try encoder.encode(tasks)
        UserDefaults.standard.set(data, forKey: PreferencesKeys.savedItems.rawValue)
      } catch {
        print("error encoding geotifications")
      }
    }

    // MARK: Functions that update the model/associated views with geotification changes
    func add(_ task: Task) {
        tasks.append(task)
      mapView.addAnnotation(task)
//      addRadiusOverlay(forTask: task)

      updateGeotificationsCount()
    }

    func remove(_ task: Task) {
      guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
      mapView.removeAnnotation(task)
//      removeRadiusOverlay(forTask: task)
      updateGeotificationsCount()
    }

    func updateGeotificationsCount() {
      let title = "Tasks: \(tasks.count)"
      print(title)
    }

    // MARK: Map overlay functions
//    func addRadiusOverlay(forTask task: Task) {
//      mapView.addOverlay(MKCircle(center: task.coordinate, radius: task.radius))
//    }

//    func removeRadiusOverlay(forTask task: Task) {
//      // Find exactly one overlay which has the same coordinates & radius to remove
//        let overlays = mapView.overlays
//      for overlay in overlays {
//        guard let circleOverlay = overlay as? MKCircle else { continue }
//        let coord = circleOverlay.coordinate
//        if coord.latitude == task.coordinate.latitude &&
//          coord.longitude == task.coordinate.longitude &&
//          circleOverlay.radius == task.radius {
//          mapView.removeOverlay(circleOverlay)
//          break
//        }
//      }
//    }
    
//    func startMonitoring(task: Task) {
//      // 1
//      if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
////        showAlert(
////          withTitle: "Error",
////          message: "Geofencing is not supported on this device!")
//        return
//      }
//
//      // 2
//      let fenceRegion = task.region
//      // 3
//      locationManager.startMonitoring(for: fenceRegion)
//    }
//
//    func stopMonitoring(task: Task) {
//      for region in locationManager.monitoredRegions {
//        guard
//          let circularRegion = region as? CLCircularRegion,
//          circularRegion.identifier == task.id
//        else { continue }
//
//        locationManager.stopMonitoring(for: circularRegion)
//      }
//    }
}
