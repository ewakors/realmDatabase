//
//  Router.swift
//  realmDatabase
//
//  Created by goapps on 22/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import Foundation
import UIKit

protocol Router: class {
    associatedtype ControllerType: Controller
    
    var controller: ControllerType? { get set }
//    var repositories: Repositories { get }
}
