//
//  ViewController.swift
//  Quick-Kick
//
//  Created by 황석현 on 12/13/24.
//

import UIKit

class ViewController: UIViewController {
    private let mainTabBarController = MainTabBarController(viewControllers: [SearchKickboardViewController(), AddKickboardViewController(), MyPageViewController()])
    private let coreDataManager = CoreDataManager.shared
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            print("ViewController DidLoad")
            print(coreDataManager.fetch())
            
            self.addChild(mainTabBarController)
            view.addSubview(mainTabBarController.view)
            mainTabBarController.view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            mainTabBarController.didMove(toParent: self)
        }
}
