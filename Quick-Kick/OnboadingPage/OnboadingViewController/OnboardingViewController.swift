//
//  OnboardingViewController.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/19/24.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    
    private let onboadingView = OnboardingPageView(title: "환영합니다!!", info: "퀵킥은 목적지까지\n빠르게 이동하기 위해\n공용 킥보드를\nQuick 하게\n빌릴 수 있는 앱입니다!", image: UIImage(named: "onboadingImage_kickboard"), isButton: false)
    
    override func loadView() {
        view = self.onboadingView
    }
    
    deinit {
        print("OnboadingViewController deinit")
    }
}
