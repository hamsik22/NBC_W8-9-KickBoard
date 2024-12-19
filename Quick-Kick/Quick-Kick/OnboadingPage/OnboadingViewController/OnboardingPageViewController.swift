//
//  OnboardingPageViewController.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/19/24.
//

import UIKit
import SnapKit

// 온보딩 화면을 관리하는 VC
final class OnboardingPageViewController: UIViewController {
    
    // 온보딩화면의 데이터 모델 배열
    private let models: [OnboardingDataModel] = {
        
        let firstOnboardingView = OnboardingDataModel(title: "환영합니다!!",
                                                      info: "퀵킥은 목적지까지\n빠르게 이동하기 위해\n공용 킥보드를\nQuick 하게\n빌릴 수 있는 앱입니다!",
                                                      image: UIImage(named: "onboadingImage_kickboard"),
                                                      isButtonHidden: true)
        
        let secondOnboardingView = OnboardingDataModel(title: "잠깐!!",
                                                       info: "안전모와 면허는\n필수인거 아시죠??",
                                                       image: UIImage(named: "onboadingImage_safe"),
                                                       isButtonHidden: true)
        
        let thirdOnboardingView = OnboardingDataModel(title: "시작합시다!!",
                                                      info: "퀵킥에 로그인하고\nQuick하게\n킥보드를 이용해요!!",
                                                      image: nil,
                                                      isButtonHidden: false)
        
        return [firstOnboardingView, secondOnboardingView, thirdOnboardingView]
    }()
    
    private lazy var onboardingView: OnboardingPageView = .init(self.models[self.currentIndex])
    
    private var pageControl = UIPageControl()
    
    private var currentIndex: Int = 0 // 현재 페이지 인덱스
    
    // MARK: - OnboardingPageViewController LifeCycle
    override func loadView() {
        view = self.onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.onboardingView.onboardingDelegate = self
        setupPageControl()
        setupLayout()
    }
}

// MARK: - OnboardingPageViewController UI Setting Method
private extension OnboardingPageViewController {
    
    /// 페이지 컨트롤러를 세팅하는 메소드
    func setupPageControl() {
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .white.withAlphaComponent(0.5)
        pageControl.backgroundColor = .PersonalNomal.nomal
        pageControl.currentPage = self.currentIndex
        pageControl.numberOfPages = 3
        self.view.addSubview(pageControl)
    }
    
    /// 레이아웃을 설정하는 메소드
    func setupLayout() {
        self.pageControl.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    /// 페이지 스와이프 애니메이션 메소드
    func swipePage() {
        UIView.transition(with: self.onboardingView, duration: 0.5, options: .transitionCrossDissolve) {
            self.setupPageControl()
            self.onboardingView.changedData(self.models[self.currentIndex])
        }
    }
}

// MARK: - OndoardingDelegate Method
extension OnboardingPageViewController: OndoardingDelegate {
    
    /// 온보딩 화면을 바꿔주는 메소드
    /// - Parameter direction: 스와이프 방향
    func changedView(_ direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case .right:
            if self.currentIndex > 0 {
                self.currentIndex -= 1
                swipePage()
            }
            
        case .left:
            if self.currentIndex < self.models.count - 1 {
                self.currentIndex += 1
                swipePage()
            }
            
        default: break
        }
    }
}
