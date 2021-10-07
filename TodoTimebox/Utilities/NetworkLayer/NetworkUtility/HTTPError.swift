//
//  HTTPError.swift
//  QueenlySwiftUI
//
//  Created by Irwin Gonzales on 6/11/21.
//

import Foundation

// Basic Error enum for safety
enum HTTPError {
    case unknown

    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown error"
        }
    }
}
