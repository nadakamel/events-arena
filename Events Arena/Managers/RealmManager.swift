//
//  RealmManager.swift
//  Events Arena
//
//  Created by Nada Kamel on 20/09/2021.
//

import Foundation
import RealmSwift

let uiRealm = try! Realm()

class RealmManager: NSObject {
    static let sharedInstance = RealmManager()
    
    func getAllDataForObject(_ T : Object.Type) -> [Object] {
        var objects = [Object]()
        for result in uiRealm.objects(T) {
            objects.append(result)
        }
        return objects
    }
    
    func getAllDataForObject(_ T : Object.Type,query :String) -> [Object] {
        var objects = [Object]()
        for result in uiRealm.objects(T).filter(query) {
            objects.append(result)
        }
        return objects
    }
    
    func deleteAllDataForObject(_ T : Object.Type) {
        self.delete(self.getAllDataForObject(T))
    }
    
    func replaceAllDataForObject(_ T : Object.Type, with objects : [Object]) {
        deleteAllDataForObject(T)
        add(objects)
    }
    
    func add(_ objects : [Object], completion : @escaping() -> ()) {
        try! uiRealm.write {
            uiRealm.add(objects, update: .modified)
            completion()
        }
    }
    
    func add(_ objects : [Object]) {
        try! uiRealm.write {
            uiRealm.add(objects, update: .modified)
        }
    }
    
    func update(_ block: @escaping ()->Void) {
        try! uiRealm.write(block)
    }
    
    func delete(_ objects : [Object]) {
        
        try! uiRealm.write{
            uiRealm.delete(objects)
        }
    }
    
}
