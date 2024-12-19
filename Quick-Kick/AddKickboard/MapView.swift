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

protocol CurrentLocationDelegate: AnyObject {
    func showLocationResetButton()
    func hideLocationResetButton()
}

class MapView: MKMapView {
    
    private let locationManager = LocationManager()
    
    weak var mapViewDelegate: MapViewDelegate?
    weak var currentLocationDelegate: CurrentLocationDelegate?
    
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
    
    func setMapCenter() {
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
        // 지도 움직임이 멈출 때마다 지도 중심 좌표를 파라미터로 전달하여 Naver API request
        mapViewDelegate?.requestNaverAddress(lat: centerCoordinate.latitude.description, lon: centerCoordinate.longitude.description)
        
        // 사용자의 현재 위치와 지도 중심이 멀어지면 현위치로 가기 button 보여주기
        /// SearchKickboardMapView - 명지님 코드 복붙 / 거리 숫자만 조정
        let mapCenter = CLLocation(latitude: mapView.centerCoordinate.latitude,
                                   longitude: mapView.centerCoordinate.longitude)
        
        if let userLocation = userLocation.location {
            let distance = mapCenter.distance(from: userLocation)
            
            if distance > 200 {
                currentLocationDelegate?.showLocationResetButton()
            } else {
                currentLocationDelegate?.hideLocationResetButton()
            }
        }
    }
}
