//
//  OnboardingPageViewController.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/19/24.
//

import UIKit
import SnapKit

final class OnboardingPageViewController: UIPageViewController {
    
    private let firstOnboardingView = OnboardingPageView(title: "환영합니다!!",
                                                         info: "퀵킥은 목적지까지\n빠르게 이동하기 위해\n공용 킥보드를\nQuick 하게\n빌릴 수 있는 앱입니다!",
                                                         image: UIImage(named: "onboadingImage_kickboard"),
                                                         isButton: true)
    
    private let secondOnboardingView = OnboardingPageView(title: "잠깐!!",
                                                          info: "안전모와 면허는\n필수인거 아시죠??",
                                                          image: UIImage(named: "onboadingImage_safe"),
                                                          isButton: true)
    
    private let thirdOnboardingView = OnboardingPageView(title: "시작합시다!!",
                                                         info: "퀵킥에 로그인하고\nQuick하게\n킥보드를 이용해요!!",
                                                         image: nil,
                                                         isButton: false)
    
    private lazy var pages: [UIViewController] = [
        OnboardingViewController(view: self.firstOnboardingView),
        OnboardingViewController(view: self.secondOnboardingView),
        OnboardingViewController(view: self.thirdOnboardingView)
    ]
    
    private var pageControl: UIPageControl!
        
    private var currentIndex: Int = 0
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        pageControl = UIPageControl.appearance()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .white.withAlphaComponent(0.5)
        pageControl.backgroundColor = .PersonalNomal.nomal
        
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame =  UIScreen.main.bounds
            } else if view is UIPageControl{
                view.backgroundColor = .clear
            }
        }
    }
    
}

extension OnboardingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let visibleVC = viewControllers?.first, let index = pages.firstIndex(of: visibleVC) {
            self.currentIndex = index
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
}
