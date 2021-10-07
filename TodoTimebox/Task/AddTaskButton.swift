//
//  AddTaskButton.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 8/5/21.
//

import SwiftUI

struct AddTaskButton: View {
    @Binding var plusButtonTapped : Bool
    
    var body: some View {
        Button(action: { plusButtonTapped.toggle() }, label: {
            if plusButtonTapped == true {
                Image(systemName:  "xmark")
                    .font(.title)
                    .padding(10)
                    .background(Color.primary)
                    .clipShape(Circle())
            } else {
                Image(systemName:  "plus")
                    .font(.title)
                    .padding(10)
                    .background(Color.primary)
                    .clipShape(Circle())
            }
        })
    }
}

