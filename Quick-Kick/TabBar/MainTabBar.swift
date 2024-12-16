//
//  MainTabBar.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/16/24.
//

import UIKit
import SnapKit

final class MainTabBar: UIView {
    
    weak var tabBarDelegate: TabBarDelegate?
    
    private lazy var tabBar: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width / 3, height: 50)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let tabBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.PersonalLight.light
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTabBarBackgorundView()
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
        setupTabBarBackgorundView()
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
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.tabBarBackgroundView.snp.top)
            $0.height.equalTo(50)
        }
    }
    
    private func setupTabBarBackgorundView() {
        self.addSubview(self.tabBarBackgroundView)
        
        self.tabBarBackgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(30)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tabBarDelegate?.changeVC(indexPath.row)
    }
}
