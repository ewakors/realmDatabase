//
//  MainController.swift
//  realmDatabase
//
//  Created by goapps on 22/11/2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import UIKit

final class MainController: UIViewController, Controller {
    var presenter: MainPresenter!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    @IBOutlet weak var realmButton: UIButton! {
        didSet {
            realmButton.titleLabel?.text = R.string.localizable.realm()
        }
    }
    
     @IBAction func realmButtonTouch(_ sender: UIButton) {
        presenter.didTouchRealm()
    }
}
