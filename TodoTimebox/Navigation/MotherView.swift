//
//  MotherView.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 7/1/21.
//

import SwiftUI

enum Page {
    case page1
}

struct MotherView: View {
    
    @State var currentPage: Page = .page1
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        switch currentPage {
        case .page1:
            ContentView(viewRouter: viewRouter, plusButtonTapped: false, listButtonTapped: false)
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(viewRouter: ViewRouter())
    }
}
