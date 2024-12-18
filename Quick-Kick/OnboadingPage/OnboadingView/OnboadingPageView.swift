//
//  OnboadingPageView.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/19/24.
//

import UIKit
import SnapKit

final class OnboadingPageView: UIView {
    
    private let titleLabel = UILabel()
    
    private let infoLabel = UILabel()
    
    private let infoImageView = UIImageView()
    
    init(title: String, info: String, image: UIImage?) {
        self.titleLabel.text = title
        self.infoLabel.text = info
        self.infoImageView.image = image
        
        super.init(frame: .infinite)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configUI()
    }
    
    private func configUI() {
        self.backgroundColor = .PersonalNomal.nomal
        
        setupTitleLabel()
        setupInfoLabel()
        setupImageView()
        setupLayout()
    }
    
    private func setupTitleLabel() {
        self.titleLabel.backgroundColor = .clear
        self.titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        self.titleLabel.textColor = .white
        self.titleLabel.textAlignment = .center
        self.titleLabel.numberOfLines = 1
        self.addSubview(self.titleLabel)
    }
    
    private func setupInfoLabel() {
        self.infoLabel.backgroundColor = .clear
        self.infoLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.infoLabel.textColor = .white
        self.infoLabel.textAlignment = .center
        self.infoLabel.numberOfLines = 0
        self.addSubview(self.infoLabel)
    }
    
    private func setupImageView() {
        self.infoImageView.contentMode = .scaleAspectFit
        self.infoImageView.backgroundColor = .clear
        self.addSubview(self.infoImageView)
    }
    
    private func setupLayout() {
        self.titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(120)
        }
        
        self.infoLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(20)
        }
        
        self.infoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.infoLabel.snp.bottom).offset(20)
            $0.width.equalTo(320)
        }
    }
    
}
