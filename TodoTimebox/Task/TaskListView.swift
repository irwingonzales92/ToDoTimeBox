//
//  TaskListView.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 8/5/21.
//

import SwiftUI

struct TaskListView: View {

    @ObservedObject var viewModel : TaskViewModel
    
    var body: some View {
        List(viewModel.tasks, rowContent: { task in
                Image(systemName: "plus")
                    .clipShape(Circle())
                Text(task.eventTitle ?? "None")
        })
        .background(RoundedRectangle(cornerRadius: 50, style: .continuous)
                .fill(Color.white)
                        .frame(width: 350, height: 350))
        .frame(maxWidth: 350, maxHeight: 350, alignment: .bottomLeading)

    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(viewModel: TaskViewModel())
    }
}
