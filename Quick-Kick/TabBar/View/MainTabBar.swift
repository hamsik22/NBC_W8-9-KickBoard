//
//  MainTabBar.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/16/24.
//

import UIKit
import SnapKit

// 현재 페이지 상태를 나타내는 enum
enum PageIndex {
    case search
    case registration
    case myPage
}

// 탭바 UI를 구현하는 UIView
final class MainTabBar: UIView {
    
    weak var tabBarDelegate: TabBarDelegate? // 탭바의 데이터 전송 델리게이트
    
    private var pageIndex: PageIndex = .search // 기본적으로 메인 페이지(킥보드 찾기 페이지)
    
    // 탭바
    private lazy var tabBar: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width / 3, height: 50)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // 탭바의 하단 -> safeArea 바깥을 표현하는 용도
    private let tabBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.PersonalLight.light
        
        return view
    }()
    
    private let indicator = UIView()
    
    // MARK: - MainTabBar Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTabBarBackgorundView()
        setupTabBar()
        setupIndicator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
        setupTabBarBackgorundView()
        setupTabBar()
        setupIndicator()
    }
    
    // MARK: - MainTabBar UI Setting Method
    
    /// 탭바의 UI를 세팅하는 메소드
    private func setupTabBar() {
        self.tabBar.delegate = self
        self.tabBar.dataSource = self
        self.tabBar.register(TabBarItem.self, forCellWithReuseIdentifier: TabBarItem.id)
        self.tabBar.backgroundColor = .PersonalLight.light
        self.tabBar.showsVerticalScrollIndicator = false
        self.tabBar.showsHorizontalScrollIndicator = false
        self.tabBar.clipsToBounds = true
        
        self.addSubview(self.tabBar)
        
        self.tabBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.tabBarBackgroundView.snp.top)
            $0.height.equalTo(50)
        }
    }
    
    /// 탭바 하단의 UI를 세팅하는 메소드
    private func setupTabBarBackgorundView() {
        self.addSubview(self.tabBarBackgroundView)
        
        self.tabBarBackgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
    
    private func setupIndicator() {
        self.indicator.backgroundColor = .PersonalNomal.nomal
        self.indicator.layer.cornerRadius = 3
        
        let constraintX = (UIScreen.main.bounds.width / 3) / 2 - 25
        self.indicator.frame = .init(x: constraintX, y: self.tabBar.frame.origin.y - 3, width: 50, height: 6)
        
        self.tabBar.addSubview(self.indicator)
    }
    
    private func moveIndicator() {
        let constraintX: CGFloat
        
        switch self.pageIndex {
        case .search:
            constraintX = (UIScreen.main.bounds.width / 3) / 2 - 25
        case .registration:
            constraintX = (UIScreen.main.bounds.width / 2) - 25
        case .myPage:
            constraintX = (UIScreen.main.bounds.width - ((UIScreen.main.bounds.width / 3) / 2 + 25))
        }
        
        UIView.animate(withDuration: 0.3) {
            self.indicator.frame.origin.x = constraintX
            self.indicator.layoutIfNeeded()
        }
    }
}

// MARK: - MainTabBar CollectionView Method
extension MainTabBar: UICollectionViewDelegate, UICollectionViewDataSource {
    // 셀의 수량 설정
    // 킥보드 찾기, 킥보드 등록, 마이 페이지로 3개의 셀
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    // 셀의 모양을 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarItem.id, for: indexPath) as? TabBarItem else {
            return UICollectionViewCell()
        }
        
        cell.setupLabelConfig(indexPath.row)
        cell.selectedTab(self.pageIndex)
        
        return cell
    }
    
    // 셀이 선택되었을 때 액션 구현
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.pageIndex = .search
        case 1:
            self.pageIndex = .registration
        case 2:
            self.pageIndex = .myPage
        default: break
        }
        
        moveIndicator()
        collectionView.reloadData()
        self.tabBarDelegate?.changeVC(indexPath.row)
    }
}
