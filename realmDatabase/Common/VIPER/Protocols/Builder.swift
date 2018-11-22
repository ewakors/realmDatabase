//
//  Builder.swift
//  realmDatabase
//
//  Created by goapps on 22/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import Foundation

protocol Builder {
    associatedtype ControllerType: Controller
    typealias PresenterType = ControllerType.PresenterType
    typealias RouterType = PresenterType.RouterType
    typealias InteractorType = PresenterType.InteractorType
    
    func controller() -> ControllerType
    func presenter() -> PresenterType
    func router() -> RouterType
    func interactor() -> InteractorType
}
