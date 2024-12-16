//
//  MapView.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import MapKit
import CoreLocation

class MapView: MKMapView {
    
    // temporary current location
    private let latitude: CLLocationDegrees = 37.497952
    private let longitude: CLLocationDegrees = 127.027619
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isPitchEnabled = false
        delegate = self
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        centerCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: 200, maxCenterCoordinateDistance: 2000), animated: true)
    }
    
    private func getPlacename(for coordindate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordindate.latitude, longitude: coordindate.longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            placemarks?.forEach({
                print($0.name)
            })
        }
    }
}

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(centerCoordinate)
        getPlacename(for: centerCoordinate)
    }
}
