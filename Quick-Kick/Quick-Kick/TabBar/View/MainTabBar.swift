//
//  MainTabBar.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/16/24.
//

import UIKit
import SnapKit

// 현재 페이지 상태를 나타내는 enum
enum PageIndex: String {
    case search = "킥보드 찾기"
    case registration = "킥보드 등록"
    case myPage = "마이 페이지"
    
    mutating func changedPageIndex(_ index: Int) {
        switch index {
        case 0:
            self = .search
        case 1:
            self = .registration
        case 2:
            self = .myPage
            
        default: break
        }
    }
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
    
    private let indicator = UIView()
    
    // MARK: - MainTabBar Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .PersonalLight.light
        
        setupTabBar()
        setupIndicator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .PersonalLight.light
    
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
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
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
            constraintX = (self.bounds.width / 3) / 2 - 25
        case .registration:
            constraintX = (self.bounds.width / 2) - 25
        case .myPage:
            constraintX = (self.bounds.width - ((self.bounds.width / 3) / 2 + 25))
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
        
        cell.setupLabelConfig(indexPath.item)
        cell.selectedTab(self.pageIndex)
        
        return cell
    }
    
    // 셀이 선택되었을 때 액션 구현
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.pageIndex.changedPageIndex(indexPath.item)
        
        moveIndicator()
        collectionView.reloadData()
        self.tabBarDelegate?.changeVC(indexPath.item)
    }
}
