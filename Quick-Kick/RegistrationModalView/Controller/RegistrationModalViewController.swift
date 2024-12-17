//
//  RefistrationModalViewController.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/17/24.
//

import UIKit
import SnapKit

final class RegistrationModalViewController: UIViewController {
    
    private var _typeSeleted: Bool = false
    private var _haveNickNameText: Bool = false
    private var _haveLocationText: Bool = false
    
    private let textField = RegistrationTextField()
    private let typeButton = KickboardTypeButton()
    private let addButton = RegistrationButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTypeButton()
        setupTextField()
        setupAddButton()
    }
    
    private func setupTextField() {
        self.textField.registrationDelegate = self
        view.addSubview(self.textField)
        
        self.textField.snp.makeConstraints {
            $0.top.equalTo(self.typeButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
            $0.height.equalTo(120)
        }
    }
    
    private func setupTypeButton() {
        self.typeButton.registrationDelegate = self
        view.addSubview(self.typeButton)
        
        self.typeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(170)
            $0.width.equalTo(320)
        }
    }
    
    private func setupAddButton() {
        view.addSubview(self.addButton)
        
        self.addButton.snp.makeConstraints {
            $0.top.equalTo(self.textField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(60)
            $0.width.equalTo(320)
        }
    }
}

extension RegistrationModalViewController: RegistrationViewDelegate {
    var typeSeleted: Bool {
        get { return self._typeSeleted }
        set { self._typeSeleted = newValue }
    }
    
    var haveNickNameText: Bool {
        get { return self._haveNickNameText }
        set { self._haveNickNameText = newValue }
    }
    
    var haveLocationText: Bool {
        get { return self._haveLocationText }
        set { self._haveLocationText = newValue }
    }
    
    
    func activateButton() {
        guard self.typeSeleted, self.haveLocationText, self.haveNickNameText else {
            self.addButton.activateButton(false)
            return
        }
        
        self.addButton.activateButton(true)
    }
    
}

