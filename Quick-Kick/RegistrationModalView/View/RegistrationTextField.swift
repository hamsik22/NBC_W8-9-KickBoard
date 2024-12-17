//
//  RegistrationTextField.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/17/24.
//

import UIKit
import SnapKit

final class RegistrationTextField: UIView {
    
    private let ninkNameField = UITextField()
    
    private let locationField = UITextField()
    
    weak var registrationDelegate: RegistrationViewDelegate?
    
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
    
    private func setupTextField() {
        [self.ninkNameField, self.locationField].forEach {
            $0.textColor = .PersonalLight.active
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
    
    private func addActions() {
        self.ninkNameField.addTarget(self, action: #selector(haveNickNameText), for: .editingChanged)
        self.locationField.addTarget(self, action: #selector(haveLocationText), for: .editingChanged)
    }
    
    @objc private func haveNickNameText() {
        print(#function)
        if self.ninkNameField.text == nil {
            self.registrationDelegate?.haveNickNameText = false
        } else {
            self.registrationDelegate?.haveNickNameText = true
        }
        
        self.registrationDelegate?.activateButton()
    }
    
    @objc private func haveLocationText() {
        print(#function)
        if self.locationField.text == nil {
            self.registrationDelegate?.haveLocationText = false
        } else {
            self.registrationDelegate?.haveLocationText = true
        }
        
        self.registrationDelegate?.activateButton()
    }
    
    private func setupPlaceHolder() {
        let placeholderNickNameText = "별명을 입력해 주세요."
        self.ninkNameField.attributedPlaceholder = NSAttributedString(
            string: placeholderNickNameText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.PersonalLight.active]
        )
        
        let placeholderLocationText = "상세한 위치를 설명해 주세요."
        self.locationField.attributedPlaceholder = NSAttributedString(
            string: placeholderLocationText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.PersonalLight.active]
        )
    }
    
    private func setupLayout() {
        self.ninkNameField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        self.locationField.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
