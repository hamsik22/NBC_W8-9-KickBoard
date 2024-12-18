//
//  SearchKickboardView.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit
import SnapKit

protocol SearchKickboardViewDelegate: AnyObject {
    func getKickboardsData() -> [Kickboard]
}

final class SearchKickboardView: UIView {
    private let searchKickboardMapView = SearchKickboardMapView()
    private lazy var searchLocationBarView: SearchLocationBarView = {
        let view = SearchLocationBarView()
        view.mapView = searchKickboardMapView
        view.layer.zPosition = 1
        return view
    }()
    
    private let locationResetButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.image = UIImage(named: "LocationResetButtonIcon.png")
        config.title = "현위치로 가기"
        config.imagePadding = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        config.imagePlacement = .leading
        config.background.backgroundColor = UIColor(named: "personalLight/light")
        config.baseForegroundColor = UIColor(named: "personalDark/darker")
        config.cornerStyle = .capsule
        button.configuration = config
        return button
    }()
    
    weak var delegate: SearchKickboardViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupAutoLayout()
        setupAddTarget()
        setupKickboardsData()
        searchLocationBarView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        self.addSubview(searchKickboardMapView)
        self.addSubview(locationResetButton)
        self.addSubview(searchLocationBarView)
    }
    
    private func setupAutoLayout() {
        self.searchKickboardMapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        locationResetButton.snp.makeConstraints {
            $0.top.equalTo(searchLocationBarView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        searchLocationBarView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(-15)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    private func setupAddTarget() {
        self.locationResetButton.addTarget(self, action: #selector(locationResetButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func locationResetButtonTapped() {
        searchKickboardMapView.moveToUserLocation()
    }
}

extension SearchKickboardView {
    private func setupKickboardsData() {
        // 1. 델리게이트(뷰 컨트롤러)에서 킥보드 데이터 가져옴
        if let kickboards = delegate?.getKickboardsData() {
            // 2. 킥보드 데이터를 mapView로 전달
            self.searchKickboardMapView.setupKickboardsData(kickboards: kickboards)
        }
    }
}

extension SearchKickboardView: SearchLocationBarViewDelegate {
    func searchResultsTableViewWillShow() {
        locationResetButton.isEnabled = false
    }
    
    func searchResultsTableViewWillHide() {
        locationResetButton.isEnabled = true
    }
    
    
}
