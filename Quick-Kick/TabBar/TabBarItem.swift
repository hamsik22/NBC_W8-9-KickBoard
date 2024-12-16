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
        self.tabButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        // VC 변경 메소드
        print(#function)
    }
    
    private func setupLayout() {
        self.tabButton.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setupButtonConfig(_ row: Int) {
        self.tabButton.setTitle(self.tabTitle[row], for: .normal)
        self.tabButton.setTitle(self.tabTitle[row], for: .selected)
        self.tabButton.tag = row
    }
    
    func selectedTab(_ isSelected: Bool) {
        guard isSelected else { return }
        
        self.tabButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.tabButton.isSelected = true
        self.tabButton.layoutIfNeeded()
    }
}
