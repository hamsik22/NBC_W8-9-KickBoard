//
//  TabBarItem.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/16/24.
//

import UIKit
import SnapKit

final class TabBarItem: UICollectionViewCell {
    
    private let tabTitle: [String] = ["킥보드 찾기", "킥보드 등록", "마이 페이지"]
    private let tabImage: [UIImage] = []
    
    private let tabButton =  UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.addSubview(self.tabButton)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = .clear
        self.addSubview(self.tabButton)
        
        configUI()
    }
    
    private func configUI() {
        setupButton()
        setupLayout()
    }
    
    private func setupButton() {
        self.tabButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.tabButton.setTitleColor(UIColor.PersonalDark.darker, for: .normal)
        self.tabButton.setTitleColor(UIColor.PersonalNomal.nomal, for: .selected)
        self.tabButton.backgroundColor = .clear
    }
    
    private func setupLayout() {
        self.tabButton.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setupButtonConfig(_ row: Int) {
        self.tabButton.setTitle(self.tabTitle[row], for: .normal)
        self.tabButton.setTitle(self.tabTitle[row], for: .selected)
    }
}
