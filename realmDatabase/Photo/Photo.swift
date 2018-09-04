//
//  Picture.swift
//  realmDatabase
//
//  Created by goapps on 03.09.2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import RealmSwift

class Photo: Object {
    @objc dynamic var uuid: String = UUID().uuidString
    @objc dynamic var imageName = ""
    @objc dynamic var image: Data = Data()
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
