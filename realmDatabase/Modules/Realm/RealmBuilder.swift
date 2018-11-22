//
//  RealmBuilder.swift
//  realmDatabase
//
//  Created by goapps on 22/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import UIKit

final class RealmBuilder: BaseBuilder {

}

extension RealmBuilder: Builder {
    func controller() -> RealmController {
        return R.storyboard.realm.instantiateInitialViewController()!
    }
    
    func presenter() -> RealmPresenter {
        return RealmPresenter()
    }
    
    func router() -> RealmRouter {
        return RealmRouter()
    }
    
    func interactor() -> RealmInteractor {
        return RealmInteractor()
    }
}

