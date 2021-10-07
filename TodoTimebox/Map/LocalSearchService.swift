//
//  LocalSearchService.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 8/14/21.
//

import Foundation
import MapKit
import SwiftUI
import CoreLocation
import Combine


final class LocalSearchService {
    let localSearchPublisher = PassthroughSubject<[MKMapItem], Never>()
    private let center: CLLocationCoordinate2D
    private let radius: CLLocationDistance
    
    init(in center: CLLocationCoordinate2D, radius: CLLocationDistance = 10) {
        self.radius = radius
        self.center = center
    }
        
    public func searchPointOfInterest(searchText: String) {
        request(searchText: searchText)
    }
    
    private func request(resultType: MKLocalSearch.ResultType = .pointOfInterest,
                         searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.pointOfInterestFilter = .includingAll
        request.region = MKCoordinateRegion(center: center, latitudinalMeters: radius, longitudinalMeters: radius)
        
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self](response, _) in
            guard let response = response else {
                return
            }
            
            self?.localSearchPublisher.send(response.mapItems)
        }
    }
}
