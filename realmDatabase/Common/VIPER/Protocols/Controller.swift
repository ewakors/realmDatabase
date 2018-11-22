//
//  Controller.swift
//  realmDatabase
//
//  Created by goapps on 22/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import Foundation

protocol Controller: class {
    associatedtype PresenterType: Presenter
    
    var presenter: PresenterType! { get set }
}
