//
//  RegistrationButton.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/17/24.
//

import UIKit
import SnapKit

// 모달뷰의 등록하기 버튼 뷰
final class RegistrationButton: UIView {
    
    private let addButton = UIButton()
    
    // MARK: - RegistrationButton Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        setupButton()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = .clear
        
        setupButton()
        setupLayout()
    }
    
    /// 등록하기 버튼을 활성화 시키는 메소드
    /// - Parameter isActivate: 활성화 여부
    func activateButton(_ isActivate: Bool) {
        switch isActivate {
        case true:
            self.addButton.isEnabled = true
            self.addButton.backgroundColor = .PersonalNomal.nomal
            self.addButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        case false:
            self.addButton.isEnabled = false
            self.addButton.backgroundColor = .PersonalLight.light
        }
    }
}

// MARK: - RegistrationButton UI Setting Method
private extension RegistrationButton {
    /// 버튼을 세팅하는 메소드
    func setupButton() {
        self.addButton.setTitle("등록하기", for: .normal)
        self.addButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.addButton.backgroundColor = .PersonalLight.light
        self.addButton.layer.cornerRadius = 30
        self.addButton.isEnabled = false
        
        self.addSubview(self.addButton)
    }
    
    /// 버튼의 레이아웃을 설정하는 메소드
    func setupLayout() {
        self.addButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - RegistrationButton Objective-C Method
@objc private extension RegistrationButton {
    /// 버튼을 눌렀을 때 액션
    func buttonTapped() {
        // CoreData에 데이터 전달
        print(#function)
    }
}
