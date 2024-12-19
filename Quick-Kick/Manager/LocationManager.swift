//
//  LocationManager.swift
//  Quick-Kick
//
//  Created by EMILY on 18/12/2024.
//

import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation()
}

class LocationManager: NSObject {
    
    weak var delegate: LocationManagerDelegate?
    
    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()
    
    var currentLocation: CLLocation? {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:     // 위치정보 수집 허용 시 : 사용자 위치 반환
            locationManager.location
        default:                                            // 위치정보 수집 불허용/미허용 상태 : 강남역 위치 반환
            CLLocation(latitude: 37.497952, longitude: 127.027619)
        }
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location Authorization Allowed")
            delegate?.didUpdateLocation()
        default:
            print("Location Authorization Not Allowed")
        }
    }
}
