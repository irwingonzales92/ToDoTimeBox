//
//  TaskListViewButton.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 8/13/21.
//

import SwiftUI

struct TaskListViewButton: View {
    @Binding var listButtonTapped : Bool
    
    var body: some View {
        Button(action: { listButtonTapped.toggle() }, label: {
            if listButtonTapped == true {
                Image(systemName:  "xmark")
                    .font(.title)
                    .padding(10)
                    .background(Color.primary)
                    .clipShape(Circle())
            } else {
                Image(systemName:  "list.dash")
                    .font(.title)
                    .padding(10)
                    .background(Color.primary)
                    .clipShape(Circle())
            }
        })
    }
}
