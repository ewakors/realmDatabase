//
//  BaseBuilder.swift
//  realmDatabase
//
//  Created by goapps on 22/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import Foundation

class BaseBuilder {
   
}

extension Builder where Self: BaseBuilder {
    func build() -> ControllerType {
        let controller = self.controller()
        let presenter = self.presenter()
        let interactor = self.interactor()
        let router = self.router()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.controller = controller as? ControllerType.PresenterType.ControllerType
        
        interactor.presenter = presenter as? ControllerType.PresenterType.InteractorType.PresenterType
        
        router.controller = controller as? ControllerType.PresenterType.RouterType.ControllerType
        
        controller.presenter = presenter
        
        return controller
    }
}
