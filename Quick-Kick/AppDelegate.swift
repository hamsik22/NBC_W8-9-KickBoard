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
        window.rootViewController = UINavigationController(rootViewController: setInitialView())
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
    
    private func setInitialView() -> UIViewController {
        print("isLoggedIn:\(UserDefaultsManager.shared.isLoggedIn)")
        print("autoLoginOption:\(UserDefaultsManager.shared.autoLoginOption)")
        print("onboarded:\(UserDefaultsManager.shared.onboarded)")
        if UserDefaultsManager.shared.isLoggedIn {
            return ViewController()
        } else if UserDefaultsManager.shared.autoLoginOption {
            return ViewController()
        } else {
            return LoginViewController()
        }
    }
}
