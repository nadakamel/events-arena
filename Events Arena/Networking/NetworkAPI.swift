//
//  APIEndpoint.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import Foundation

enum NetworkAPI {
    case getEventTypes
    case getEventListing(eventType: String, page: Int)
}

extension NetworkAPI: EndpointType {
    
    private var urlString: String {
        return "http://private-7466b-eventtuschanllengeapis.apiary-mock.com"
    }
    
    var baseURL: URL {
        guard let url = URL(string: urlString) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .getEventTypes:
            return "/eventtypes"
        case .getEventListing:
            return "/events"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getEventTypes, .getEventListing:
            return .get
        }
    }
    
    var urlParameters: Parameters? {
        switch self {
        case .getEventTypes:
            return nil
        case .getEventListing(let eventType, let page):
            return ["event_type":eventType, "page":page]
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var task: HTTPTask {
        return .requestParameters(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: urlParameters)
    }

}
