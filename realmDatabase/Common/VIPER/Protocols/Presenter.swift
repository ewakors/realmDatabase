//
//  Presenter.swift
//  realmDatabase
//
//  Created by goapps on 22/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import Foundation

protocol Presenter: class {
    associatedtype RouterType: BaseRouter, Router
    associatedtype InteractorType: Interactor
    associatedtype ControllerType: Controller
    
    var router: RouterType! { get set }
    var interactor: InteractorType! { get set }
    var controller: ControllerType? { get set }
}
