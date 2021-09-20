//
//  EventTypeDetails.swift
//  Events Arena
//
//  Created by Nada Kamel on 19/09/2021.
//

import Foundation
import RealmSwift

// MARK: - EventTypeDetails
@objcMembers class EventTypeDetails: Object {
    
    dynamic var type: EventType?
    dynamic var event: EventDetails?
    dynamic var id: String = ""

    override class func primaryKey() -> String? {
        return "id"
    }
    
    override init() {
     
    }
    
    init(type: EventType, event: EventDetails) {
        self.type = type
        self.event = event
        self.id = "\(type.id)-\(event.id)"
    }
    
}
