//
//  OnboardingPageView.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/19/24.
//

import UIKit
import SnapKit

final class OnboardingPageView: UIView {
    
    private let titleLabel = UILabel()
    
    private let infoLabel = UILabel()
    
    private let infoImageView = UIImageView()
    
    private let startButton = UIButton()
    
    weak var onboardingDelegate: OndoardingDelegate?
    
    init(data: OnboardingDataModel) {
        self.titleLabel.text = data.title
        self.infoLabel.text = data.info
        self.infoImageView.image = data.image
        self.startButton.isHidden = data.isButtonHidden
        
        super.init(frame: .infinite)
        
        configUI()
        addSwipeGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configUI()
        addSwipeGesture()
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
        self.startButton.addTarget(self, action: #selector(changeViewController), for: .touchUpInside)
        self.addSubview(self.startButton)
    }
    
    @objc private func changeViewController() {
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
    
    private func addSwipeGesture() {
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(pageSwipe))
        swipeGestureRight.direction = .right
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(pageSwipe))
        swipeGestureLeft.direction = .left
        self.addGestureRecognizer(swipeGestureRight)
        self.addGestureRecognizer(swipeGestureLeft)
    }
    
    @objc private func pageSwipe(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                self.onboardingDelegate?.changedView(.right)
                print("right")
                
            case UISwipeGestureRecognizer.Direction.left:
                self.onboardingDelegate?.changedView(.left)
                print("left")
                
            default: break
            }
        }
    }
    
    func changedData(data: OnboardingDataModel) {
        self.titleLabel.text = data.title
        self.infoLabel.text = data.info
        self.infoImageView.image = data.image
        self.startButton.isHidden = data.isButtonHidden
        self.layoutIfNeeded()
    }
}
