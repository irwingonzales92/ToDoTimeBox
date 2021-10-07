//
//  Endpoint.swift
//  FightRank
//
//  Created by Irwin Gonzales on 5/30/21.
//

import Foundation

protocol Endpoint {
    var scheme: String {get}
    var baseURL: String {get}
    var method: HTTPMethod {get}
    var path: String {get}
    var params: [URLQueryItem] {get}
}
