//
//  Realm.swift
//  realmDatabase
//
//  Created by goapps on 22/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import Foundation

final class RealmPresenter: Presenter {
    var router: MainRouter!
    var interactor: MainInteractor!
    weak var controller: MainController?
    
    func viewWillApear() {
        
    }
}
