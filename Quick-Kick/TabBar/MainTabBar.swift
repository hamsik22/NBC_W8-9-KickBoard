//
//  MainTabBar.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/16/24.
//

import UIKit
import SnapKit

final class MainTabBar: UIView {
    
    private let tabTitle: [String] = ["킥보드 찾기", "킥보드 등록", "마이 페이지"]
    
    private lazy var tabBar: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width / 3, height: 50)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.tabBar.delegate = self
        self.tabBar.dataSource = self
        self.tabBar.register(TabBarItem.self, forCellWithReuseIdentifier: TabBarItem.id)
        self.tabBar.backgroundColor = .PersonalLight.light
        self.tabBar.showsVerticalScrollIndicator = false
        self.tabBar.showsHorizontalScrollIndicator = false
        
        self.addSubview(self.tabBar)
        
        self.tabBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}

extension MainTabBar: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarItem.id, for: indexPath) as? TabBarItem else {
            return UICollectionViewCell()
        }
        
        cell.setupButtonConfig(indexPath.row)
        
        return cell
    }
}
