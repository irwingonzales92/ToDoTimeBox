//
//  FightCardView.swift
//  FightRank
//
//  Created by Irwin Gonzales on 5/29/21.
//

import SwiftUI

struct TaskView: View {
    
    var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    var body: some View {
        
        VStack {
            HStack{
                Image(systemName: "person")
                    .padding()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                VStack {
                    Text("\(task.eventTitle ?? "")")
                        .bold()
                        .font(.title)
                    
                    HStack {
                        Text("\(task.timeTotal ?? 0)").font(.caption2)
                    }
                    Text("\(task.location ?? "")").font(.footnote)

                }
            }
        }
    }
}
