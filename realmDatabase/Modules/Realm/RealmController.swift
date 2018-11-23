//
//  RealmController.swift
//  realmDatabase
//
//  Created by goapps on 22/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import UIKit

class RealmController: UIViewController, Controller {

    var presenter: RealmPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Realm view"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem:.undo, target: self, action: #selector(backTouch))
        presenter.viewWillApear()
    }

    @objc func backTouch(_ sender: UIBarButtonItem) {
    }
}
