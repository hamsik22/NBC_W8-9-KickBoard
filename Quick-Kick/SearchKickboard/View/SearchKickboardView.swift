//
//  SearchKickboardView.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit
import SnapKit

final class SearchKickboardView: UIView {
    private let searchKickboardMapView = SearchKickboardMapView()
    private lazy var searchLocationBarView: SearchLocationBarView = {
        let view = SearchLocationBarView()
        view.mapView = searchKickboardMapView
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        self.addSubview(searchKickboardMapView)
        self.searchKickboardMapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.addSubview(searchLocationBarView)
        searchLocationBarView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
}
