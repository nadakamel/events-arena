//
//  RealmHelper.swift
//  Events Arena
//
//  Created by Nada Kamel on 20/09/2021.
//

import Foundation

class RealmHelper: NSObject {
    // MARK: - Types Related
    static func saveEventTypesToRealm(eventTypes: EventTypes) {
        RealmManager.sharedInstance.add(eventTypes)
    }
    
    static func getRealmEventTypes() -> EventTypes? {
        let realms = RealmManager.sharedInstance.getAllDataForObject(EventType.self).map{$0 as! EventType}
        return realms
    }
    
    // MARK: - Events Related
    static func saveEventTypeDetailsToRealm(eventTypeDetails: [EventTypeDetails]) {
        RealmManager.sharedInstance.add(eventTypeDetails)
    }
    
    static func getRealmEventTypeDetails() -> [EventTypeDetails]? {
        let realms = RealmManager.sharedInstance.getAllDataForObject(EventTypeDetails.self).map{$0 as! EventTypeDetails}
        
        var events: [EventTypeDetails]?
        if realms.count > 0 {
            events = []
            for realm in realms {
                events?.append(realm)
            }
        }
        
        return events
    }

    static func getRealmEventsDetails(withType type: EventType) -> EventsDetails? {
        let realms = RealmManager.sharedInstance.getAllDataForObject(EventTypeDetails.self, query: "type.name == '\(type.name ?? "")'").map{$0 as! EventTypeDetails}
        
        var events: EventsDetails?
        if realms.count > 0 {
            events = []
            for realm in realms {
                events?.append(realm.event!)
            }
        }
        
        return events
    }

}
