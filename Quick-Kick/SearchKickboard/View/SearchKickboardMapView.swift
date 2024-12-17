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
    
    private let gangnamStation = CLLocation(
        latitude: 37.498095,
        longitude: 127.027610
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
#if DEBUG
        setupDebugLocation()
#else
        setupLocation()
#endif
        setupMapView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDebugLocation() {
        setMapCenter(gangnamStation)
    }
    
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    private func setupMapView() {
        self.preferredConfiguration = MKStandardMapConfiguration()
        self.showsUserLocation = true
        self.setUserTrackingMode(.follow, animated: true)
        self.setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: 200, maxCenterCoordinateDistance: 2000), animated: true)
    }
}

extension SearchKickboardMapView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
#if DEBUG
        setMapCenter(gangnamStation)
#else
        guard let location = locations.last else { return }
        setMapCenter(location)
#endif
    }
    
    private func setMapCenter(_ location: CLLocation) {
        let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 200,
            longitudinalMeters: 200
        )
        setRegion(region, animated: true)
    }
    
    func moveToUserLocation() {
        if let location = userLocation.location {
            setMapCenter(location)
        }
    }
}
