//
//  RegistrationViewDelegate.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/17/24.
//

import UIKit

// 모달뷰의 데이터 전달 델리게이트
protocol RegistrationViewDelegate: AnyObject {
    
    var typeSeleted: Bool { get set } // 킥보드 타입이 선택되었는가?
    
    var haveNickNameText: Bool { get set } // 킥보드 별명이 입력되었는가?
    
    var sendNickName: String? { get set } // 킥보드 이름 전달
    
    var kickboardType: Bool? { get set } // 킥보드 타입 전달
            
    func activateButton() // 버튼 활성화
    
    func savedKickboardData() // 킥보드 정보 저장
    
    func updateKickboardData() // 킥보드 정보 업데이트
}
