//
//  MapView.swift
//  
//
//  Created by Irwin Gonzales on 7/15/21.
//

import SwiftUI
import MapKit


struct MapView: UIViewRepresentable {
    @EnvironmentObject var mapData: MapViewModel
    
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = mapData.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view  
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // Turn task into placemark
        func addRadiusOverlay(forGeotification geotification: Task) {
          uiView.addOverlay(MKCircle(center: geotification.coordinate, radius: 10))
        }
        
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
          let identifier = "myTask"
          if annotation is Task {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            if annotationView == nil {
              annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
              annotationView?.canShowCallout = true
              let removeButton = UIButton(type: .custom)
              removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
              removeButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
              annotationView?.leftCalloutAccessoryView = removeButton
            } else {
              annotationView?.annotation = annotation
            }
            return annotationView
          }
          return nil
        }
        
        
        
    }
}

