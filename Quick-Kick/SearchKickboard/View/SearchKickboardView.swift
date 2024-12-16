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
    
    private let locationResetButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.image = UIImage(named: "LocationResetButtonIcon.png")
        config.title = "현위치로 가기"
        config.imagePadding = 8
        config.imagePlacement = .leading
        config.background.backgroundColor = UIColor(named: "personalLight/light")
        config.baseForegroundColor = UIColor(named: "personalDark/darker")
        config.cornerStyle = .capsule
        button.configuration = config
        return button
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
        
        self.addSubview(locationResetButton)
        locationResetButton.snp.makeConstraints {
            $0.top.equalTo(searchLocationBarView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
}
