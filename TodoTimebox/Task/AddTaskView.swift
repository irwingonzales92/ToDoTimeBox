//
//  AddTaskView.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 5/31/21.
//

import SwiftUI

struct AddTaskView: View {
    
    @ObservedObject var viewModel : TaskViewModel
    @ObservedObject var searchViewModel = SearchResultsViewModel()
    
    @State private var title = String()
    @State var location : String
    @State private var type = String()
    @State private var totalTime = Int()
    @State var plusButtonTapped : Bool
    @State var searchButtonTapped : Bool
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    
    
    var body: some View {
        VStack {
            TextField("What Is This Task Called?", text: $title)
                .font(.title2).multilineTextAlignment(.center)
                .onDisappear(perform: {self.title = ""})
            VStack {
                Divider()
                VStack {
                    TextField("What Kind Of Task Is This?", text: $type)
                        .multilineTextAlignment(.center)
                        .onDisappear {self.type = ""}
                }
                Divider()
                VStack {
                    Text(location).font(.title2)
                    Button("Set Location", action: {searchButtonTapped.toggle()})
                }
            }
            Divider()
            VStack {
                Text("How many hours will this take?")
                TextField("Time Total", value: $totalTime, formatter: formatter)
                    .multilineTextAlignment(.center)
                    .onDisappear(perform: {self.totalTime = 0})
                    
            }
            Divider()
            HStack {
                Button(action: {
                    if plusButtonTapped == true {
                        viewModel.addItems(item: self.title, totalTime: self.totalTime, type: self.type,location: self.location)
                    } else {
                        searchButtonTapped.toggle()
                    }
                }, label: {
                    Text("Confirm")
                        .background(Color.black)
                        .foregroundColor(.white)
                        .padding()
                })
                .frame(width: 100, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                .border(Color.black, width: 5)
                .cornerRadius(40)
            }
        }
        .frame(width: 300, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding()
        .foregroundColor(.black)
        .background(RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(Color.white)
            .frame(width: 350, height: 350))
        .popup(isPresented: searchButtonTapped ? true : false, alignment: .center, direction: .bottom) {
            SearchResultsView(location: $location, searchButtonTapped: $searchButtonTapped)
        }
        
    }
}
