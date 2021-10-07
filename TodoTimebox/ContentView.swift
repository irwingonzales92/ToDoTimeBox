//
//  ContentView.swift
//  FightRank
//
//  Created by Irwin Gonzales on 5/29/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    @ObservedObject private var viewModel = TaskViewModel()
    @ObservedObject private var resultsViewModel = SearchResultsViewModel()
    @StateObject var viewRouter : ViewRouter
    @StateObject var mapData = MapViewModel()
    @State var plusButtonTapped : Bool
    @State var listButtonTapped : Bool
    
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        VStack {
            NavigationView{
                ZStack {
                    // MapView
                    VStack {
                        MapView()
                            .environmentObject(mapData)
                            .ignoresSafeArea(.all, edges: .all)

                    }
                    VStack {
                        Spacer()
                        HStack {
                            // Buttom Menu
                            
                            VStack {
                                HStack{
                                    Spacer()
                                    MapButton()
                                    TaskListViewButton(listButtonTapped: $listButtonTapped)
                                    AddTaskButton(plusButtonTapped: $plusButtonTapped)
                                }
                                .frame(maxWidth: 100, alignment: .bottom)
                                .padding()
                            }
                        }.background(Color.gray.opacity(0.0))
                        
                    }

                }
                .onAppear(perform: {
                    // setting delegate
                    locationManager.delegate = mapData
                    locationManager.requestWhenInUseAuthorization()
                    mapData.loadAllGeotifications()
                })
                .popup(isPresented: plusButtonTapped ? true : false , alignment: .center, direction: .bottom) {

                    AddTaskView(viewModel: viewModel, searchViewModel: resultsViewModel, location: resultsViewModel.poiText, plusButtonTapped: plusButtonTapped, searchButtonTapped: false)
                    
                    
                }
                .popup(isPresented: listButtonTapped ? true : false , alignment: .center, direction: .bottom) {
                    TaskListView(viewModel: viewModel)
                        .onAppear(perform: {viewModel.load()})
                }

                .alert(isPresented: $mapData.permissionDenied, content: {
                    Alert(title: Text("Permission Denied"), message: Text("Enable Permission"), dismissButton: .default(Text("Dismiss"), action: {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }))
                })
            }
        }
    }
    

}


