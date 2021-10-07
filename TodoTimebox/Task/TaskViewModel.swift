//
//  FightCardViewModel.swift
//  FightRank
//
//  Created by Irwin Gonzales on 5/30/21.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreLocation
import MapKit

class TaskViewModel: ObservableObject {
    @Published var tasks = [Task]()
    @Published var finished = false
    @Published var task : Task?
    
    @ObservedObject private var searchViewModel = SearchResultsViewModel()
     
    @DateProp var taskDate = Date()
    
    var service: LocalSearchService?
    
    private let db = Firestore.firestore()
    private var ref: DocumentReference? = nil
    
    init() {
        load()
        print(self.tasks)
    }
}
extension TaskViewModel {
    func load() {
        db.collection("Task").getDocuments { snapShot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = snapShot?.documents else {
                    print("Error in fetching documents: \(error?.localizedDescription ?? "")")
                    return
                }
                self.tasks = documents.compactMap({ (snapShot) -> Task? in
                    print(self.tasks)
                    return try? snapShot.data(as: Task.self)
                })
            }
        }
    }

    // Find place to plug this into for the map
    func getConvertTaskToPlacemark(task: Task) -> CLLocationCoordinate2D {
        let location = CLLocationCoordinate2D()
        task.longitude = location.longitude
        task.latitude = location.latitude
        print(location)
        return location
    }
    func addItems(item: String, totalTime: Int, type: String, location: String){
        // refrences DB to create a task
        self.convertPlacemarkToTask(poi: location) { (result: Result<Task, Error>) in
            switch result {
            case .success(let task):
                print(task)
                self.ref = self.db.collection("Task").addDocument(data: [
                    "eventTitle":item,
                    "totalTime":totalTime,
                    "type":type,
                    "location": location,
                    "latitude": Double(task.latitude),
                    "longitude": Double(task.longitude)
                ], completion: { (err) in
                    guard err != nil else {return}
                    print("saved")
                    self.finished.toggle()
                })
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTasks() {
        db.collection("Tasks").addSnapshotListener { snapShot, error in
            guard let documents = snapShot?.documents else {
                print("Error in fetching documents: \(error?.localizedDescription ?? "")")
                return
            }
            self.tasks = documents.compactMap({ (snapShot) -> Task? in
                return try? snapShot.data(as: Task.self)
            })
            let tasks = documents.map { $0["title"] }
            print("Tasks: \(tasks)")
        }
    }
    
    func convertPlacemarkToTask(poi: String, completion: @escaping (Result<Task, Error>)->()){
        let geoCoder = CLGeocoder()

        geoCoder.geocodeAddressString(poi) { placeMakers, err in
            guard err == nil else {
                completion(.failure(err as! Error))
                return
            }
            guard placeMakers != nil else { return }
            var task : Task
            
            if let placeMark = placeMakers!.first {
                // Convert placemark
                task = Task(eventTitle: placeMark.description ,cooridnate: placeMark.location!.coordinate, latitude: (placeMark.location?.coordinate.latitude)!, longitude: (placeMark.location?.coordinate.longitude)!, timeTotal: 0, location: placeMark.name!)
                completion(.success(task))
            }
        }
    }
}
