//
//  SearchKickboardMapView.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit
import MapKit
import SnapKit
import CoreLocation

final class SearchKickboardMapView: MKMapView {
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.preferredConfiguration = MKHybridMapConfiguration()
        map.showsUserLocation = true
        map.setUserTrackingMode(.follow, animated: true)
        return map
    }()
    
    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
