//
//  AddKickboardView.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import UIKit
import SnapKit

class AddKickboardView: UIView {
    
    private lazy var mapView: MapView = .init()
    
    private lazy var noticeView: NoticeView = .init()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        
        button.tintColor = UIColor.PersonalNomal.nomal
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 70)
        button.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: imageConfig), for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addButton.layer.cornerRadius = addButton.bounds.width / 2
    }
    
    private func addSubviews() {
        [mapView, noticeView, addButton]
            .forEach { addSubview($0) }
    }
    
    private func layout() {
        backgroundColor = .systemBackground
        
        let safeArea = safeAreaLayoutGuide
        
        mapView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        noticeView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(100)
        }
        
        addButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().offset(-32)
            $0.height.width.equalTo(70)
        }
    }
}
