//
//  TabBarDelegate.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/16/24.
//

import UIKit

// 탭바의 데이터 전송을 위한 델리게이트
protocol TabBarDelegate: AnyObject {
    
    func changeVC(_ index: Int) // 현재 보여지는 VC를 변경하는 메소드
}
