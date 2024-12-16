//
//  MainTabBarController.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/16/24.
//

import UIKit
import SnapKit

// 커스텀 탭바 컨트롤러
final class MainTabBarController: UIViewController {
    
    private let tabBar = MainTabBar() // 탭바 UI
    
    private let viewControllers: [UIViewController] // 표시할 VC 목록
    private var currentVC: UIViewController? // 현재 VC
    
    // MARK: - MainTabBarController Initializer
    init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MainTabBarController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .PersonalLight.light
        
        setupTabBar()
        displayViewController(0)
    }
    
    // MARK: - MainTabBarController UI Setting Method
    /// 탭바의 UI를 세팅하는 메소드
    private func setupTabBar() {
        self.tabBar.tabBarDelegate = self
        view.addSubview(self.tabBar)
        
        self.tabBar.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
    }
    
    /// 현재 보여지는 뷰를 관리하는 메소드
    /// - Parameter index: 몇 번째 뷰를 보여줄 것인지
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
        
        self.currentVC = selectedVC // 현재 VC를 선택한 VC로 변경
    }
}

// MARK: - MainTabBarController Delegate Method
extension MainTabBarController: TabBarDelegate {
    func changeVC(_ index: Int) {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve) {
            self.displayViewController(index)
        }
    }
}
