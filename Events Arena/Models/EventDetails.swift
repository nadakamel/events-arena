//
//  EventDetails.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import Foundation
import RealmSwift

typealias EventsDetails = [EventDetails]

// MARK: - EventDetails
@objcMembers class EventDetails: Object, Decodable {
    
    dynamic var longitude, latitude, endDate, startDate: String?
    dynamic var eventDetailDescription: String?
    dynamic var cover: String?
    dynamic var name: String?
    dynamic var id: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case longitude, latitude
        case endDate = "end_date"
        case startDate = "start_date"
        case eventDetailDescription = "description"
        case cover, name, id
    }
    
    /// EventDetails convenience initializer
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.longitude = try container.decode(String.self, forKey: .longitude)
        self.latitude = try container.decode(String.self, forKey: .latitude)
        self.endDate = try container.decode(String.self, forKey: .endDate)
        self.startDate = try container.decode(String.self, forKey: .startDate)
        self.eventDetailDescription = try container.decode(String.self, forKey: .eventDetailDescription)
        self.cover = try container.decode(String.self, forKey: .cover)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
}
