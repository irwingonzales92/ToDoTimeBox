//
//  SearchResultsViewModel.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 8/13/21.
//

import Foundation
import MapKit
import Combine

final class SearchResultsViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    
    @Published var poiText = "" {
        didSet {
            searchForPOI(text: poiText)
        }
    }
    
    @Published var viewData = [LocalSearchViewData]()
    
    var service: LocalSearchService
    
    // TODO: Set Center to User Location
    init() {
        let center = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
        service = LocalSearchService(in: center)
        
        cancellable = service.localSearchPublisher.sink(receiveValue: { mapItems in
            self.viewData = mapItems.map( {LocalSearchViewData(mapItem: $0)})
        })
    }
    
    private func searchForPOI(text: String) {
        service.searchPointOfInterest(searchText: text)
    }
    

}
