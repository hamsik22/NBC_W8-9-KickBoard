//
//  RegistrationTextField.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/17/24.
//

import UIKit
import SnapKit

// 모달뷰의 텍스트필드 뷰
final class RegistrationTextField: UIView {
    
    private let nickNameField = UITextField()
    
    private let locationField = UITextField()
    
    weak var registrationDelegate: RegistrationViewDelegate?
    
    // MARK: - RegistrationTextField Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        setupTextField()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = .clear
        
        setupTextField()
        setupLayout()
    }
    
    func updateData(_ text: String) {
        self.nickNameField.text = text
        haveNickNameText()
    }
}

// MARK: - RegistrationTextField UI Setting Method
private extension RegistrationTextField {
    /// 텍스트필드를 세팅하는 메소드
    func setupTextField() {
        [self.nickNameField, self.locationField].forEach {
            $0.textColor = .PersonalDark.darker
            $0.textAlignment = .left
            $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            $0.borderStyle = .none
            $0.clearButtonMode = .whileEditing
            $0.autocapitalizationType = .none
            $0.backgroundColor = .PersonalLight.light
            $0.layer.cornerRadius = 10
            $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            $0.leftViewMode = .always
            $0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            $0.rightViewMode = .always
            self.addSubview($0)
        }
        
        setupPlaceHolder()
        addActions()
    }
    
    /// 텍스트필드 액션을 세팅하는 메소드
    func addActions() {
        self.nickNameField.addTarget(self, action: #selector(haveNickNameText), for: .editingChanged)
    }
    
    /// 텍스트필드 플레이스홀더를 세팅하는 메소드
    func setupPlaceHolder() {
        let placeholderNickNameText = "별명을 입력해 주세요."
        self.nickNameField.attributedPlaceholder = NSAttributedString(
            string: placeholderNickNameText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.PersonalLight.active]
        )
        
        let placeholderLocationText = "상세한 위치를 설명해 주세요."
        self.locationField.attributedPlaceholder = NSAttributedString(
            string: placeholderLocationText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.PersonalLight.active]
        )
    }
    
    /// 텍스트필드의 레이아웃을 세팅하는 메소드
    func setupLayout() {
        self.nickNameField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        self.locationField.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}

// MARK: - RegistrationTextField Objective-C Method
@objc private extension RegistrationTextField {
    
    /// 닉네임 텍스트 필드에 변경이 있을 경우 실행될 액션 메소드
    func haveNickNameText() {
        print(#function)
        if self.nickNameField.text?.count ?? 0 > 0 {
            self.registrationDelegate?.haveNickNameText = true
            self.registrationDelegate?.sendNickName = self.nickNameField.text
        } else {
            self.registrationDelegate?.haveNickNameText = false
        }
        
        self.registrationDelegate?.activateButton()
    }
}
