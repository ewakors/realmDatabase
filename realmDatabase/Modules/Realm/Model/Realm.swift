//
//  Realm.swift
//  realmDatabase
//
//  Created by goapps on 23/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCommit : Object {
    @objc dynamic var sha: String = ""
    @objc dynamic var message: String = ""
    @objc dynamic var date: Date = Date(timeIntervalSince1970: 1)
    
    override class func primaryKey() -> String? {
        return "sha"
    }
    
    let authors = LinkingObjects(fromType: RealmUser.self, property: "commits")
}

class RealmUser : Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var login: String = ""
    let commits = List<RealmCommit>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
