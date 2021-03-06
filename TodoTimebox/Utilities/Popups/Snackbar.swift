//
//  Snackbar.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 7/27/21.
//

import SwiftUI

struct Snackbar: View {
    var body: some View {
        HStack() {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text("Irwin")
                    .foregroundColor(.black)
                    .font(.headline)

                Text("Time To Move On To The Next Thing")
                    .font(.body)
                    .foregroundColor(.black)
            }
        }
        .padding(15)
        .frame(maxWidth: .infinity, idealHeight: 100)
        .background(Color.black.opacity(0.1))
    }
}
