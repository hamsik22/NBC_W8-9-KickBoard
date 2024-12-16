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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(mapView)
    }
    
    private func layout() {
        backgroundColor = .systemBackground
        
        mapView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
