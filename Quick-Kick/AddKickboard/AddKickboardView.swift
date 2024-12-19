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
    
    /// SearchKickboardView - 명지님 코드 복붙 / 시간 없어서 객체 분리 X
    private lazy var locationResetButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
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
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        
        button.tintColor = UIColor.PersonalNomal.nomal
        button.backgroundColor = .systemBackground
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 60)
        button.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: imageConfig), for: .normal)
        button.imageView?.contentMode = .center
        
        return button
    }()
    
    private lazy var centerPinImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = .mapPicker
        
        return imageView
    }()
    
    weak var modalViewDelegate: ModalViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layout()
        setAction()
        mapView.currentLocationDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addButton.layer.cornerRadius = addButton.bounds.width / 2
    }
    
    private func addSubviews() {
        [mapView, noticeView, locationResetButton, addButton, centerPinImage]
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
        
        locationResetButton.snp.makeConstraints {
            $0.top.equalTo(noticeView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        addButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().offset(-32)
            $0.height.width.equalTo(60)
        }
        
        centerPinImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-35)
            $0.height.equalTo(70)
        }
    }
    
    func setDelegate(_ mapViewDelegate: MapViewDelegate, _ repository: AddressRepository) {
        mapView.mapViewDelegate = mapViewDelegate
        repository.delegate = noticeView
    }
    
    private func setAction() {
        self.addButton.addTarget(self, action: #selector(presentModal), for: .touchUpInside)
        self.locationResetButton.addTarget(self, action: #selector(resetLocation), for: .touchUpInside)
    }
    
    @objc private func presentModal() {
        self.modalViewDelegate?.presentModalView(mapView.centerCoordinate.latitude, mapView.centerCoordinate.longitude, address: noticeView.address)
    }
    
    @objc private func resetLocation() {
        mapView.setMapCenter()
    }
}

extension AddKickboardView: CurrentLocationDelegate {
    func showLocationResetButton() {
        locationResetButton.isHidden = false
    }
    
    func hideLocationResetButton() {
        locationResetButton.isHidden = true
    }
}
