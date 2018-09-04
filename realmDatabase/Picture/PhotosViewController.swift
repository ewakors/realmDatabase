//
//  PicturesViewController.swift
//  realmDatabase
//
//  Created by goapps on 03.09.2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet weak var photoName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.white
        photoName?.text = "photo name"
    }
}
