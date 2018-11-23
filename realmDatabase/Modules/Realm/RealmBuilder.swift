//
//  RealmBuilder.swift
//  realmDatabase
//
//  Created by goapps on 22/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import UIKit

final class RealmBuilder: BaseBuilder {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    func buildWithNav() -> UINavigationController {
        let viewController = build()
        return UINavigationController(rootViewController: viewController)
    }
}

extension RealmBuilder: Builder {
    func router() -> MainRouter {
        return MainRouter(window: window)
    }
    
    func interactor() -> MainInteractor {
        return MainInteractor()
    }
    

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

