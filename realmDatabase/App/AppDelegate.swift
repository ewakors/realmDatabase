//
//  AppDelegate.swift
//  realmDatabase
//
//  Created by goapps on 03.09.2018.
//  Copyright © 2018 ewa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = MainBuilder(window: window).buildWithNav()
        window.rootViewController = rootViewController
        
        self.window = window
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

