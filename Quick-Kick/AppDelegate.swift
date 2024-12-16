//
//  AppDelegate.swift
//  Quick-Kick
//
//  Created by 황석현 on 12/13/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: AddKickboardViewController())
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}

