//
//  EndpointType.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import Foundation

typealias HTTPHeaders = [String: String]

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
