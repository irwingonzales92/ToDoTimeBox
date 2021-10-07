//
//  NetworkEngine.swift
//  FightRank
//
//  Created by Irwin Gonzales on 5/30/21.
//

import Foundation
import SwiftUI

class NetworkEngine {
    class func request<T: Codable>(endPoint: Endpoint, completion: @escaping (Result<T, Error>)->()){
        
        var components = URLComponents()
        components.scheme = endPoint.scheme
        components.path = endPoint.path
        components.host = endPoint.baseURL
        components.queryItems = endPoint.params
        
        guard let url = components.url else { return }
        
        let request = URLRequest(url: url)
        let urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession.dataTask(with: request) { (data, res, err) in
            
            guard err == nil else {
                completion(.failure(err!))
                print(err?.localizedDescription ?? "Unknown Error")
                return }
            
            guard res != nil, let data = data else { return }
            
            DispatchQueue.main.async {
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    completion(.failure(HTTPError.unknown as! Error))
                }
            }
        }
        dataTask.resume()
    }
}
