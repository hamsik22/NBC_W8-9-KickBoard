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
        self.addButton.backgroundColor = .PersonalNomal.nomal
        self.addButton.layer.cornerRadius = 30
        self.addButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        self.addSubview(self.addButton)
    }
    
    @objc private func buttonTapped() {
        
    }
    
    private func setupLayout() {
        self.addButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
