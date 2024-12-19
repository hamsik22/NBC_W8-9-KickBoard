//
//  OnboardingPageView.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/19/24.
//

import UIKit
import SnapKit

// 온보딩 화면을 구현하는 뷰
final class OnboardingPageView: UIView {
    
    private let titleLabel = UILabel()
    
    private let infoLabel = UILabel()
    
    private let infoImageView = UIImageView()
    
    private let startButton = UIButton()
    
    weak var onboardingDelegate: OndoardingDelegate?
    
    // MARK: - OnboardingPageView Initializer
    init(_ data: OnboardingDataModel) {
        self.titleLabel.text = data.title
        self.infoLabel.text = data.info
        self.infoImageView.image = data.image
        self.startButton.isHidden = data.isButtonHidden
        
        super.init(frame: .infinite)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 현재 뷰의 표시 데이터를 변경하는 메소드
    /// - Parameter data: 데이터 모델
    func changedData(_ data: OnboardingDataModel) {
        self.titleLabel.text = data.title
        self.infoLabel.text = data.info
        self.infoImageView.image = data.image
        self.startButton.isHidden = data.isButtonHidden
        self.layoutIfNeeded()
    }
}

// MARK: - OnboardingPageView UI Setting Method
private extension OnboardingPageView {
    
    /// 온보딩 뷰의 모든 UI를 세팅하는 메소드
    func configUI() {
        self.backgroundColor = .PersonalNomal.nomal
        
        setupTitleLabel()
        setupInfoLabel()
        setupImageView()
        setupButton()
        setupLayout()
        addSwipeGesture()
    }
    
    /// 타이틀 레이블을 설정하는 메소드
    func setupTitleLabel() {
        self.titleLabel.backgroundColor = .clear
        self.titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        self.titleLabel.textColor = .white
        self.titleLabel.textAlignment = .center
        self.titleLabel.numberOfLines = 1
        self.addSubview(self.titleLabel)
    }
    
    /// 설명 레이블을 설정하는 메소드
    func setupInfoLabel() {
        self.infoLabel.backgroundColor = .clear
        self.infoLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.infoLabel.textColor = .white
        self.infoLabel.textAlignment = .center
        self.infoLabel.numberOfLines = 0
        self.addSubview(self.infoLabel)
    }
    
    /// 이미지뷰를 설정하는 메소드
    func setupImageView() {
        self.infoImageView.contentMode = .scaleAspectFit
        self.infoImageView.backgroundColor = .clear
        self.addSubview(self.infoImageView)
    }
    
    /// 버튼을 설정하는 메소드
    func setupButton() {
        self.startButton.setTitle("시작하기", for: .normal)
        self.startButton.setTitleColor(UIColor.PersonalNomal.nomal, for: .normal)
        self.startButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.startButton.backgroundColor = UIColor.PersonalLight.hover
        self.startButton.layer.cornerRadius = 25
        self.startButton.addTarget(self, action: #selector(changeViewController), for: .touchUpInside)
        self.addSubview(self.startButton)
    }
    
    /// 모든 레이아웃을 설정하는 메소드
    func setupLayout() {
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
    
    /// 뷰에 스와이프 제스처를 추가하는 메소드
    func addSwipeGesture() {
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(pageSwipe))
        swipeGestureRight.direction = .right
        
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(pageSwipe))
        swipeGestureLeft.direction = .left
        
        self.addGestureRecognizer(swipeGestureRight)
        self.addGestureRecognizer(swipeGestureLeft)
    }
}

// MARK: - OnboardingPageView Objective-C Method
@objc private extension OnboardingPageView {
    
    /// 뷰 컨트롤러를 바꾸는 메소드
    func changeViewController() {
        DispatchQueue.main.async {
            UIView.transition(with: self.window!, duration: 0.5, options: .transitionCrossDissolve) {
                self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
            }
        }
    }
    
    /// 뷰의 화면을 업데이트 하는 메소드
    /// - Parameter gesture: 스와이프 방향
    func pageSwipe(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                self.onboardingDelegate?.changedView(.right)
                
            case UISwipeGestureRecognizer.Direction.left:
                self.onboardingDelegate?.changedView(.left)
                
            default: break
            }
        }
    }
    
}
