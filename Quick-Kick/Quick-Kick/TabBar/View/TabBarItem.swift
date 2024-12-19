//
//  TabBarItem.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/16/24.
//

import UIKit
import SnapKit

// 탭바의 아이템(셀) 설정
final class TabBarItem: UICollectionViewCell {
    
    static let id: String = "TabBarItem" // 셀의 고유 이름
    
    private var pageIndex: PageIndex = .search
        
    private let tabLabel =  UILabel() // 탭의 타이틀 UI
    
    // MARK: - TabBarItem Initializer
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
    
    // 셀 UI 재사용 설정
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.backgroundColor = .clear
        self.addSubview(self.tabLabel)
        
        configUI()
    }
    
    // MARK: - TabBarItem UI Setting Method
    /// 모든 UI를 세팅하는 메소드
    private func configUI() {
        setupLabel()
        setupLayout()
    }
    
    /// 탭의 UI를 세팅하는 메소드
    private func setupLabel() {
        self.tabLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.tabLabel.textColor = UIColor.PersonalDark.darker
        self.tabLabel.numberOfLines = 1
        self.tabLabel.textAlignment = .center
        self.tabLabel.backgroundColor = .clear
    }
    
    /// 탭의 모든 UI 레이아웃을 세팅하는 메소드
    private func setupLayout() {
        self.tabLabel.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    /// 셀의 레이블을 설정하는 메소드
    /// - Parameter item: 현재 셀의 indexPath item
    func setupLabelConfig(_ item: Int) {
        self.pageIndex.changedPageIndex(item)
        
        self.tabLabel.text = self.pageIndex.rawValue
    }
    
    /// 셀이 선택되었을 때 강조를 해주는 메소드
    /// - Parameter isSelected: 셀이 선택되었는지 확인
    func selectedTab(_ pageIndex: PageIndex) {
        guard pageIndex == self.pageIndex else { return }
        
        self.tabLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.tabLabel.textColor = UIColor.PersonalNomal.nomal
        self.tabLabel.layoutIfNeeded()
    }
}
