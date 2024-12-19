//
//  SearchKickboardMapView.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit
import MapKit
import CoreLocation

protocol SearchKickboardMapViewDelegate: AnyObject {
    func showLocationResetButton()
    func hideLocationResetButton()
}

final class SearchKickboardMapView: MKMapView {
    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        return manager
    }()
    
    private var kickboards: [Kickboard]?
    weak var mapViewDelegate: SearchKickboardMapViewDelegate?
    
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
        self.delegate = self
    }
    
    func setupKickboardsData(kickboards: [Kickboard]) {
        self.kickboards = kickboards
        addMarkersOnMap()
    }
    
    private func addMarkersOnMap() {
        removeAnnotations(annotations)
        
        self.kickboards?.forEach({ kickboard in
            if kickboard.startTime == nil {
                let annotation = KickboardAnnotation(kickboard: kickboard)
                self.addAnnotation(annotation)
            }
        })
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

extension SearchKickboardMapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        let identifier = "mapPicker"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = annotation
        }
        
        if let kickboardAnnotation = annotation as? KickboardAnnotation {
            // isOccupied 상태에 따라 다른 이미지 설정
            if kickboardAnnotation.kickboard.isOccupied {
                annotationView?.image = UIImage(named: "myMapPicker")  // 내 킥보드
            } else {
                annotationView?.image = UIImage(named: "mapPicker")  // 남의 킥보드
            }
        }
        
        annotationView?.frame.size = CGSize(width: 55, height: 91)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        if annotation is MKUserLocation {
            return
        }
        guard let kickboardAnnotation = annotation as? KickboardAnnotation else { return }
        let kickboard = kickboardAnnotation.kickboard
        
        let rentKickboardModalView = RentKickboardModalView(kickboard: kickboard)
        self.addSubview(rentKickboardModalView)
        rentKickboardModalView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // 맵의 중심 좌표
        let mapCenter = CLLocation(latitude: mapView.centerCoordinate.latitude,
                                   longitude: mapView.centerCoordinate.longitude)
        
        // 사용자 현재 위치
        if let userLocation = userLocation.location {
            // 두 위치 간의 거리
            let distance = mapCenter.distance(from: userLocation)
            
            // 50미터 이상 차이나면 버튼 보여주기
            if distance > 50 {
                mapViewDelegate?.showLocationResetButton()
            } else {
                mapViewDelegate?.hideLocationResetButton()
            }
        }
    }
}
