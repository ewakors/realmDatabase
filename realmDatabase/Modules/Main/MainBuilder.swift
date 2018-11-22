//
//  MainBuilder.swift
//  realmDatabase
//
//  Created by goapps on 22/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import UIKit

final class MainBuilder: BaseBuilder {
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

extension MainBuilder: Builder {
    func controller() -> MainController {
        return R.storyboard.main.instantiateInitialViewController()!
    }

    func presenter() -> MainPresenter {
        return MainPresenter()
    }
    
    func router() -> MainRouter {
        return MainRouter(window: window)
    }
    
    func interactor() -> MainInteractor {
        return MainInteractor()
    }
}
