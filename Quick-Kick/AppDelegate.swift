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
<<<<<<< HEAD
        window.rootViewController = UINavigationController(rootViewController: ViewController())
=======
        window.rootViewController = UINavigationController(rootViewController: setInitialView())
>>>>>>> develop
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    private func setInitialView() -> UIViewController {
        if UserDefaultsManager.shared.isLoggedIn {
            return LoginViewController()
        } else if UserDefaultsManager.shared.autoLoginOption {
            return ViewController()
        } else {
            return LoginViewController()
        }
    }
}
