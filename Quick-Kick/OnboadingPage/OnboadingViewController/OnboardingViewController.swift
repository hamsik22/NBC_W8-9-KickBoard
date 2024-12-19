//
//  OnboardingViewController.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/19/24.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    
    private let onboardingView: UIView
    
    init(view: UIView) {
        self.onboardingView = view
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = self.onboardingView
    }
}
