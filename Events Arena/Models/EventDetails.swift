//
//  EventDetails.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import Foundation

// MARK: - EventDetails
struct EventDetails: Codable {
    let longitude, latitude, endDate, startDate: String?
    let eventDetailDescription: String?
    let cover: String?
    let name, id: String?

    enum CodingKeys: String, CodingKey {
        case longitude, latitude
        case endDate = "end_date"
        case startDate = "start_date"
        case eventDetailDescription = "description"
        case cover, name, id
    }
}

// MARK: EventDetails convenience initializers and mutators

extension EventDetails {
    init(data: Data) throws {
        self = try JSONDecoder().decode(EventDetails.self, from: data)
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

    func with(
        longitude: String?? = nil,
        latitude: String?? = nil,
        endDate: String?? = nil,
        startDate: String?? = nil,
        eventDetailDescription: String?? = nil,
        cover: String?? = nil,
        name: String?? = nil,
        id: String?? = nil
    ) -> EventDetails {
        return EventDetails(
            longitude: longitude ?? self.longitude,
            latitude: latitude ?? self.latitude,
            endDate: endDate ?? self.endDate,
            startDate: startDate ?? self.startDate,
            eventDetailDescription: eventDetailDescription ?? self.eventDetailDescription,
            cover: cover ?? self.cover,
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
