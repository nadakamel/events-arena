//
//  NetworkManager.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import Foundation

protocol NetworkManager {
    func sendRequest(apiMethod: NetworkAPI, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkManagerImp: NetworkManager {
    private let router = Router<NetworkAPI>()
    
    func sendRequest(apiMethod: NetworkAPI, completion: @escaping (Result<Data, Error>) -> Void) {
        router.request(apiMethod) { data, response, error in
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    if let d = data {
                        completion(.success(d))
                    }
                default:
                    if let e = error {
                        completion(.failure(e))
                    }
                }
            }
        }
    }
    
}
