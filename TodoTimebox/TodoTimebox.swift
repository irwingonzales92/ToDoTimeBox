//
//  TodoTimebox.swift
//  FightRank
//
//  Created by Irwin Gonzales on 5/29/21.
//

import SwiftUI
import Firebase

@main
struct TodoTimebox: App {
    @StateObject var viewRouter = ViewRouter()
   
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MotherView(viewRouter: ViewRouter())
        }
    }
}



