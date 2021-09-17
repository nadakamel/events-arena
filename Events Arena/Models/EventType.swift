//
//  EventType.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import Foundation

// MARK: - EventType
struct EventType: Codable {
    let name, id: String?
}

// MARK: EventType convenience initializers and mutators

extension EventType {
    init(data: Data) throws {
        self = try JSONDecoder().decode(EventType.self, from: data)
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
    
    func with(name: String?? = nil, id: String?? = nil) -> EventType {
        return EventType(
            name: name ?? self.name,
            id: id ?? self.id
        )
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
