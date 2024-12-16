//
//  SearchKickboardMapView.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit
import MapKit
import CoreLocation

final class SearchKickboardMapView: MKMapView {
    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLocation()
        setupMapView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    private func setupMapView() {
        self.preferredConfiguration = MKHybridMapConfiguration()
        self.showsUserLocation = true
        self.setUserTrackingMode(.follow, animated: true)
    }
}

extension SearchKickboardMapView: CLLocationManagerDelegate {
    
}
