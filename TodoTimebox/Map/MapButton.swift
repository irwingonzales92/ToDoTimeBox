//
//  MapButton.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 8/5/21.
//

import SwiftUI

struct MapButton: View {
    @StateObject var mapData = MapViewModel()
    
    var body: some View {
        Button(action: mapData.focusLocation, label: {
            Image(systemName: mapData.mapType == .standard ?
                "network" : "map")
                .font(.title)
                .padding(10)
                .background(Color.primary)
                .clipShape(Circle())
        })
    }
}

