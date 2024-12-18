//
//  MyKickboardDetailView.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/18/24.
//

import UIKit
import SnapKit

final class MyKickboardDetailView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = .init(width: self.bounds.width - 30, height: 120)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(MyKickboardDetailViewItem.self, forCellWithReuseIdentifier: MyKickboardDetailViewItem.id)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupCollectionView()
        setupLayout()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        
        self.addSubview(self.collectionView)
    }
    
    private func setupLayout() {
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MyKickboardDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyKickboardDetailViewItem.id, for: indexPath) as? MyKickboardDetailViewItem else {
            return UICollectionViewCell()
        }
        
        cell.insertKickboardImage(type: false)
        cell.useKickboard(false)
        
        return cell
    }
    
    
}
