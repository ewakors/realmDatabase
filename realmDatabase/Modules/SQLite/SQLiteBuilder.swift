//
//  SQLiteBuilder.swift
//  realmDatabase
//
//  Created by goapps on 23/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import Foundation

final class SQLiteBuilder: BaseBuilder {
    
}

extension SQLiteBuilder: Builder {
    func controller() -> SQLiteController {
        return R.storyboard.sqLite.instantiateInitialViewController()!
    }
    
    func presenter() -> SQLitePresenter {
        return SQLitePresenter()
    }
    
    func router() -> SQLiteRouter {
        return SQLiteRouter()
    }
    
    func interactor() -> SQLiteInteractor {
        return SQLiteInteractor()
    }
}
