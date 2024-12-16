//
//  MapView.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import MapKit

class MapView: MKMapView {
    
    // temporary current location
    private let latitude: CLLocationDegrees = 37.497952
    private let longitude: CLLocationDegrees = 127.027619
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: 200, maxCenterCoordinateDistance: 2000), animated: true)
    }
}
