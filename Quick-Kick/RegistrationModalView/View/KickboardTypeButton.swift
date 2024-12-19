//
//  KickboardTypeButton.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/17/24.
//

import UIKit
import SnapKit

// 모달뷰에서 킥보드의 타입을 선택하는 버튼 뷰
final class KickboardTypeButton: UIView {
    
    private let quickboardNormalTypeButton = UIButton()
    
    private let quickboardSeatTypeButton = UIButton()
    
    private let normalLabel = UILabel()
    
    private let seatLabel = UILabel()
    
    weak var registrationDelegate: RegistrationViewDelegate?
    
    // MARK: - KickboardTypeButton Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        setupButton()
        setupLabel()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = .clear
        
        setupButton()
        setupLayout()
    }
    
    func updateData(_ type: Bool) {
        switch type {
        case true:
            self.quickboardSeatTypeButton.backgroundColor = .PersonalLight.active
            self.quickboardSeatTypeButton.isSelected = true
        case false:
            self.quickboardNormalTypeButton.backgroundColor = .PersonalLight.active
            self.quickboardNormalTypeButton.isSelected = true
        }
        self.registrationDelegate?.typeSeleted = true
    }
}

// MARK: - KickboardTypeButton UI Setting Method
private extension KickboardTypeButton {
    /// 버튼을 세팅하는 메소드
    func setupButton() {
        [self.quickboardNormalTypeButton,
         self.quickboardSeatTypeButton].forEach {
            $0.backgroundColor = .clear
            $0.layer.borderColor = UIColor.PersonalLight.active.cgColor
            $0.layer.borderWidth = 2
            $0.layer.cornerRadius = 20
            $0.imageView?.contentMode = .scaleAspectFit
            $0.contentEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
            self.addSubview($0)
        }
        self.quickboardNormalTypeButton.tag = 0
        self.quickboardSeatTypeButton.tag = 1
        
        setupImage()
        setupAction()
    }
    
    /// 버튼의 이미지를 세팅하는 메소드
    func setupImage() {
        self.quickboardNormalTypeButton.setImage(UIImage(named: "QuickBoard"), for: .normal)
        self.quickboardSeatTypeButton.setImage(UIImage(named: "QuickBoard - Seat"), for: .normal)
    }
    
    /// 버튼의 액션을 세팅하는 메소드
    func setupAction() {
        self.quickboardNormalTypeButton.addTarget(self, action: #selector(selectedNormalButton), for: .touchUpInside)
        self.quickboardSeatTypeButton.addTarget(self, action: #selector(selectedSeatButton), for: .touchUpInside)
    }
    
    /// 레이블을 세팅하는 메소드
    func setupLabel() {
        [self.normalLabel, self.seatLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            $0.textColor = .black
            $0.textAlignment = .center
            self.addSubview($0)
        }
        
        self.normalLabel.text = "일반형"
        self.seatLabel.text = "안장형"
    }
    
    /// 전체 UI의 레이아웃을 세팅하는 메소드
    func setupLayout() {
        self.quickboardNormalTypeButton.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.height.width.equalTo(150)
        }
        
        self.quickboardSeatTypeButton.snp.makeConstraints {
            $0.trailing.top.equalToSuperview()
            $0.height.width.equalTo(150)
        }
        
        self.normalLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.quickboardNormalTypeButton)
            $0.top.equalTo(self.quickboardNormalTypeButton.snp.bottom).offset(5)
        }
        
        self.seatLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.quickboardSeatTypeButton)
            $0.top.equalTo(self.quickboardSeatTypeButton.snp.bottom).offset(5)
        }
    }
}

// MARK: - KickboardTypeButton Objective-C Method
@objc private extension KickboardTypeButton {
    
    /// 노말 타입의 버튼을 선택했을 때 작동할 메소드
    func selectedNormalButton() {
        if self.quickboardNormalTypeButton.isSelected {
            self.quickboardNormalTypeButton.backgroundColor = .clear
            self.quickboardNormalTypeButton.isSelected = false
            self.registrationDelegate?.typeSeleted = false
        } else {
            self.quickboardNormalTypeButton.backgroundColor = .PersonalLight.active
            self.quickboardNormalTypeButton.isSelected = true
            self.registrationDelegate?.typeSeleted = true
            self.registrationDelegate?.kickboardType = false
        }
        
        self.quickboardSeatTypeButton.backgroundColor = .clear
        self.quickboardSeatTypeButton.isSelected = false
        self.registrationDelegate?.activateButton()
    }
    
    /// 안장 타입의 버튼을 선택했을 때 작동할 메소드
    func selectedSeatButton() {
        if self.quickboardSeatTypeButton.isSelected {
            self.quickboardSeatTypeButton.backgroundColor = .clear
            self.quickboardSeatTypeButton.isSelected = false
            self.registrationDelegate?.typeSeleted = false
        } else {
            self.quickboardSeatTypeButton.backgroundColor = .PersonalLight.active
            self.quickboardSeatTypeButton.isSelected = true
            self.registrationDelegate?.typeSeleted = true
            self.registrationDelegate?.kickboardType = true
        }
        
        self.quickboardNormalTypeButton.backgroundColor = .clear
        self.quickboardNormalTypeButton.isSelected = false
        self.registrationDelegate?.activateButton()
    }
}
