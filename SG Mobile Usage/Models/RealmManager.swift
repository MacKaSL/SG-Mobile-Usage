//
//  RealmManager.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/19/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import RealmSwift

class RealmManager {
    
    static func save(_ o: Object...) throws {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(o, update: true)
            }
            if realm.isInWriteTransaction {
                try realm.commitWrite()
            }
        } catch let e {
            print("######## Realm saving error: ", e.localizedDescription)
            throw ErrorParser.parsed(e.localizedDescription, errorCode: Constants.ErrorCode.realmSaveFailed)
        }
    }
    
    static func delete(_ o: Object) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(o)
            }
        } catch let e {
            print("######## Realm deleting error: ", e.localizedDescription)
        }
    }
    
    /// Removes all records of a given Object
    ///
    /// - Parameter class: Realm Object Class
    /// - Throws: Removing error
    static func removeAll<T: Object>(class: T) throws {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete((realm.objects(T.self)))
            }
        } catch let e {
            print("######## Realm removeAll error: ", e.localizedDescription)
            throw ErrorParser.parsed(e.localizedDescription, errorCode: Constants.ErrorCode.realmDeleteAllFailed)
        }
    }
    
}
