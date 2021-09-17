//
//  HTTPTask.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import Foundation

enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
