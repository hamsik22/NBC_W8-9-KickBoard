//
//  TabBarItem.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/16/24.
//

import UIKit
import SnapKit

final class TabBarItem: UICollectionViewCell {
    
    static let id: String = "TabBarItem"
    
    private let tabTitle: [String] = ["킥보드 찾기", "킥보드 등록", "마이 페이지"]
    private let tabImage: [UIImage] = []
    
    private let tabLabel =  UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.addSubview(self.tabLabel)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = .clear
        self.addSubview(self.tabLabel)
        
        configUI()
    }
    
    private func configUI() {
        setupButton()
        setupLayout()
    }
    
    private func setupButton() {
        self.tabLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.tabLabel.textColor = UIColor.PersonalDark.darker
        self.tabLabel.numberOfLines = 1
        self.tabLabel.textAlignment = .center
        self.tabLabel.backgroundColor = .clear
    }
    
    private func setupLayout() {
        self.tabLabel.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setupButtonConfig(_ row: Int) {
        self.tabLabel.text = self.tabTitle[row]
        self.tabLabel.tag = row
    }
    
    func selectedTab(_ isSelected: Bool) {
        guard isSelected else { return }
        
        self.tabLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.tabLabel.textColor = UIColor.PersonalNomal.nomal
        self.tabLabel.layoutIfNeeded()
    }
}
