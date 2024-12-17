//
//  Kickboard.swift
//  Quick-Kick
//
//  Created by 반성준 on 12/16/24.
//

import Foundation

struct Kickboard {
    let name: String
    let isSeat: Bool
    let address: String
    var isInUse: Bool = false  // 기본값 설정
    var type: String = "일반형" // 기본값 설정
}
