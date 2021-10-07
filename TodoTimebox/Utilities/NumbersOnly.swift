//
//  NumbersOnly.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 5/31/21.
//

import Foundation

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
