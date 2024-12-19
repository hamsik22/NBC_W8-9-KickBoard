//
//  MapView.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import MapKit
import CoreLocation

protocol MapViewDelegate: AnyObject {
    func requestNaverAddress(lat: String, lon: String)
}

class MapView: MKMapView {
    
    private let locationManager = LocationManager()
    
    weak var mapViewDelegate: MapViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        locationManager.delegate = self
        setup()
        setMapCenter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        isPitchEnabled = false
        showsUserLocation = true
        
        setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: 200, maxCenterCoordinateDistance: 2000), animated: true)
    }
    
    private func setMapCenter() {
        guard let location = locationManager.currentLocation else {
            return
        }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        setRegion(region, animated: true)
    }
}

extension MapView: MKMapViewDelegate, LocationManagerDelegate {
    func didUpdateLocation() {
        setMapCenter()
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(centerCoordinate)
        mapViewDelegate?.requestNaverAddress(lat: centerCoordinate.latitude.description, lon: centerCoordinate.longitude.description)
    }
}
