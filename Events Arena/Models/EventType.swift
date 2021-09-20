//
//  EventType.swift
//  Events Arena
//
//  Created by Nada Kamel on 16/09/2021.
//

import Foundation
import RealmSwift

typealias EventTypes = [EventType]

// MARK: - EventType
@objcMembers class EventType: Object, Decodable {
    
    dynamic var id: String = ""
    dynamic var name: String?

    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    /// EventType convenience initializer
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
}
