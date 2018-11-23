//
//  MainRouter.swift
//  realmDatabase
//
//  Created by goapps on 22/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import Foundation
import UIKit

final class MainRouter: BaseRouter, Router {
    weak var controller: MainController?
    
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    func toRealm() {
        let vc = RealmBuilder(window: window).buildWithNav()
        window.setRoot(viewController: vc)
    }
    
    func toSQLite() {
        
    }
}
