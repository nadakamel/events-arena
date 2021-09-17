//
//  EventsDetails.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import Foundation

typealias EventsDetails = [EventDetails]

extension Array where Element == EventsDetails.Element {
    init(data: Data) throws {
        self = try JSONDecoder().decode(EventsDetails.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
