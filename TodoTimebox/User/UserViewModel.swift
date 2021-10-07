//
//  UserViewModel.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 5/31/21.
//

import Foundation
import SwiftUI
import Firebase

class UserViewModel: ObservableObject {
    @Published var users = [User]()
    
    // Firebase Vars
//    let db = Firestore.firestore()
    private var ref: DocumentReference? = nil
    
    init() {
        load()
    }
}

extension UserViewModel {
    func load() {
        
    }
    
    /// DB functions
    func addName(item: String){
//        ref = db.collection("User").addDocument(data: ["name":item], completion: { (err) in
//            
//        })
    }
    
    /// Auth Functions
    func createNewUser(user: User) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
            guard authResult != nil else {
                print(error?.localizedDescription ?? "unknown error")
                return
            }
        }
    }
    
    func signInUser(user: User) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { [weak self] authResult, error in
            guard self != nil else { return }
            print("\(user.name) has signed in!")
          
        }
    }
}
