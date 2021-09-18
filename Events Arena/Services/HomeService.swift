//
//  HomeService.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import Foundation

class HomeService {
    
    func getEventTypes(_ response: @escaping (Result<EventTypes, Error>) -> Void) {
        NetworkManagerImp().sendRequest(apiMethod: .getEventTypes, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let types = try JSONDecoder().decode(EventTypes.self, from: data)
                        debugPrint(types)
                        response(.success(types))
                    } catch {
                        debugPrint("[HomeService] Failure: \(error.localizedDescription)")
                        response(.failure(error))
                    }
                    break
                case .failure(let error):
                    debugPrint("[HomeService] Failure: \(error.localizedDescription)")
                    response(.failure(error))
                }
            }
        })
    }
    
    func getEventListing(_ eventType: EventType, page: Int, _ response: @escaping (Result<EventsDetails, Error>) -> Void) {
        NetworkManagerImp().sendRequest(apiMethod: .getEventListing(eventType: eventType.name!, page: page), completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let details = try JSONDecoder().decode(EventsDetails.self, from: data)
                        debugPrint(details)
                        response(.success(details))
                    } catch {
                        debugPrint("[HomeService] Failure: \(error.localizedDescription)")
                        response(.failure(error))
                    }
                    break
                case .failure(let error):
                    debugPrint("[HomeService] Failure: \(error.localizedDescription)")
                    response(.failure(error))
                }
            }
        })
    }
}
