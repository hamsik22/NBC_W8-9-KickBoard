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
    
    private let startButton = UIButton()
    
    init(title: String, info: String, image: UIImage?, isButton: Bool) {
        self.titleLabel.text = title
        self.infoLabel.text = info
        self.infoImageView.image = image
        self.startButton.isHidden = isButton
        
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
        setupButton()
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
    
    private func setupButton() {
        self.startButton.setTitle("시작하기", for: .normal)
        self.startButton.setTitleColor(UIColor.PersonalNomal.nomal, for: .normal)
        self.startButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.startButton.backgroundColor = UIColor.PersonalLight.hover
        self.startButton.layer.cornerRadius = 25
        self.startButton.addTarget(self, action: #selector(popSelf), for: .touchUpInside)
        self.addSubview(self.startButton)
    }
    
    @objc private func popSelf() {
        DispatchQueue.main.async {
            UIView.transition(with: self.window!, duration: 0.5, options: .transitionCrossDissolve) {
                self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
            }
        }
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
        
        self.startButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalTo(300)
            $0.bottom.equalToSuperview().inset(100)
        }
    }
    
}
