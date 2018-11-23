//
//  SQLite.swift
//  realmDatabase
//
//  Created by goapps on 23/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import Foundation
import SharkORM

class SharkCommit : SRKObject {
    @objc dynamic var sha: String = ""
    @objc dynamic var message: String = ""
    @objc dynamic var date: Date = Date(timeIntervalSince1970: 1)
    @objc dynamic var user: SharkUser?
    
    override class func indexDefinitionForEntity() -> SRKIndexDefinition {
        let idx = SRKIndexDefinition()
//        idx.add("sha", order: SRKIndexSortOrderAscending)
                idx.addIndex(forProperty: "sha", propertyOrder: SRKIndexSortOrderAscending)
        return idx
    }
}

class SharkUser : SRKObject {
    @objc dynamic var userId: Int = 0  // NOTE: "id" is used by Shark
    @objc dynamic var name: String = ""
    @objc dynamic var login: String = ""
    
    override class func indexDefinitionForEntity() -> SRKIndexDefinition {
        let idx = SRKIndexDefinition()
//        idx.add("userId", order: SRKIndexSortOrderAscending)
                idx.addIndex(forProperty: "userId", propertyOrder: SRKIndexSortOrderAscending)
        return idx
    }
    
    func commits() -> SRKResultSet {
        return SharkCommit.query()
            .where(withFormat: "user = %@",
                   withParameters: [self])
            .fetch()
    }
}
