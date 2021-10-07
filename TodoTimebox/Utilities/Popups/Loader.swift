//
//  Loader.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 7/27/21.
//

import SwiftUI

struct Loader: View {
    var body: some View {
        Group {
            ProgressView("Loading…")
                .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
        }
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
    }
}
