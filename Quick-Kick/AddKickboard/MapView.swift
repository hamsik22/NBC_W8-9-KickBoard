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
    
    weak var mapViewDelegate: MapViewDelegate?
    
    // temporary current location
    private let latitude: CLLocationDegrees = 37.497952
    private let longitude: CLLocationDegrees = 127.027619
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        isPitchEnabled = false
        showsUserLocation = true
        
        centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: 200, maxCenterCoordinateDistance: 2000), animated: true)
    }
}

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(centerCoordinate)
        mapViewDelegate?.requestNaverAddress(lat: centerCoordinate.latitude.description, lon: centerCoordinate.longitude.description)
    }
}
