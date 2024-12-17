//
//  RegistrationButton.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/17/24.
//

import UIKit
import SnapKit

final class RegistrationButton: UIView {
    
    private let addButton = UIButton()
    
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
    
    private func setupButton() {
        self.addButton.setTitle("등록하기", for: .normal)
        self.addButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.addButton.backgroundColor = .PersonalLight.light
        self.addButton.layer.cornerRadius = 30
        self.addButton.isEnabled = false
        
        self.addSubview(self.addButton)
    }
    
    @objc private func buttonTapped() {
        // CoreData에 데이터 전달
        print(#function)
    }
    
    private func setupLayout() {
        self.addButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
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
