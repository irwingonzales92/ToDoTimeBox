//
//  DateProp.swift
//  TodoTimebox
//
//  Created by Irwin Gonzales on 7/7/21.
//

import Foundation

@propertyWrapper struct DateProp {
    var wrappedValue: Date {
        didSet {wrappedValue = Date()}
    }
    
    init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
    }
}
