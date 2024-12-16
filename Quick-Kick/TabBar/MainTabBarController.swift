//
//  MainTabBarController.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/16/24.
//

import UIKit
import SnapKit

final class MainTabBarController: UIViewController {
    
    private let tabBar = MainTabBar()
    
    private let viewControllers: [UIViewController]
    private var currentVC: UIViewController?
    
    init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .PersonalLight.light
        
        setupTabBar()
        displayViewController(0)
    }
    
    private func setupTabBar() {
        view.addSubview(self.tabBar)
        
        self.tabBar.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    private func displayViewController(_ index: Int) {
        if let currentVC = self.currentVC {
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }
        
        let selectedVC = viewControllers[index]
        self.addChild(selectedVC)
        self.view.insertSubview(selectedVC.view, belowSubview: self.tabBar)
        
        selectedVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        selectedVC.didMove(toParent: self)
        
        self.currentVC = selectedVC
    }
}
