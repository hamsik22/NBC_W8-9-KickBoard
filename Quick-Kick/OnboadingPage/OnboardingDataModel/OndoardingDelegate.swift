//
//  OndoardingDelegate.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/19/24.
//

import UIKit

// 온보딩 뷰 델리게이트
protocol OndoardingDelegate: AnyObject {
    
    func changedView(_ direction: UISwipeGestureRecognizer.Direction)
    
}
