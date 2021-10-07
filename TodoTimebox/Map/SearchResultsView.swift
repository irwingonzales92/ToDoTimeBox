//
//  SearchResultsView.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 8/13/21.
//

import SwiftUI

struct SearchResultsView: View {
    @StateObject private var viewModel = SearchResultsViewModel()
    @Binding var location : String
    @Binding var searchButtonTapped : Bool

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter Point of interest name", text: $viewModel.poiText)
                .background(Color.white)
                
            Divider()
            HStack {
                Text("Results")
                    .font(.title)
                    .background(Color.white)
                Spacer()
                Button("Set", action: {searchButtonTapped.toggle()})
            }

            List(viewModel.viewData) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                    Text(item.subtitle)
                    Text("")
                        .foregroundColor(.secondary)
                }.onTapGesture {
                    location = item.title
                    searchButtonTapped.toggle()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .background(Color.white)
        .ignoresSafeArea(edges: .bottom)
        
    }}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(location: .constant("Daly City"), searchButtonTapped: .constant(false))
    }
}
