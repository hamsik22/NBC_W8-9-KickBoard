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
    private let locationManager = LocationManager()
    
    private var kickboards: [Kickboard]?
    weak var mapViewDelegate: SearchKickboardMapViewDelegate?
    private(set) var rentKickboardModalView = RentKickboardModalView()
    
    private let gangnamStation = CLLocation(
        latitude: 37.498095,
        longitude: 127.027610
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMapView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMapView() {
        locationManager.delegate = self
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

extension SearchKickboardMapView: LocationManagerDelegate {
    func didUpdateLocation() {
        setMapCenter()
    }
    
    private func setMapCenter() {
        guard let location = locationManager.currentLocation else {
            return
        }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        setRegion(region, animated: true)
    }
    
    func moveToUserLocation() {
        setMapCenter()
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

extension SearchKickboardMapView {
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        if annotation is MKUserLocation {
            return
        }
        guard let kickboardAnnotation = annotation as? KickboardAnnotation else { return }
        let kickboard = kickboardAnnotation.kickboard
        
        // 모달뷰가 이미 올라와있고 && 같은 마커 클릭 경우
        if rentKickboardModalView.superview != nil && rentKickboardModalView.kickboard?.nickName == kickboard.nickName {
            return
        }
        
        showModal(for: kickboard)
    }
    
    private func showModal(for kickboard: Kickboard) {
        rentKickboardModalView.setupKickboardData(kickboard)
        rentKickboardModalView.delegate = self
        self.addSubview(rentKickboardModalView)
        
        rentKickboardModalView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.rentKickboardModalView.alpha = 1
            self.rentKickboardModalView.transform = .identity
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        
        // 모달뷰가 표시된 상태인지(슈퍼뷰를 가지는지) 체크
        if rentKickboardModalView.superview != nil {
            // 터치가 모달뷰 내부인지 체크
            let isModalTouch = hitView?.isDescendant(of: rentKickboardModalView) == true
            
            // 터치한 부분이 마커인지, 마커라면 KickboardAnnotation로 다운캐스팅이 되는지 체크
            let isSelectedMarkerTouch = if let annotationView = hitView as? MKAnnotationView,
                                           let annotation = annotationView.annotation as? KickboardAnnotation {
                // 마커의 킥보드 닉네임과 모달의 킥보드 닉네임이 같은지 체크
                annotation.kickboard.nickName == rentKickboardModalView.kickboard?.nickName
            } else {
                false
            }
            
            // 킥보드 빌린 상태인지 체크
            let isRented = rentKickboardModalView.kickboard?.startTime != nil
            
            // 모달뷰 내부이거나 현재 선택된 마커면 터치 그대로 흘려보내기
            if isModalTouch || isSelectedMarkerTouch || isRented {
                return hitView
            } else {
                // 그 외의 영역 터치시 모달 제거
                rentKickboardModalView.removeFromSuperview()
                return super.hitTest(point, with: event)
            }
        }
        return hitView
    }
}

extension SearchKickboardMapView: RentKickboardModalViewDelegate {
    func didUpdateKickboardStatus(_ kickboard: Kickboard) {
        // 킥보드 이용중인 경우
        if kickboard.startTime != nil {
            // 마커 찾기
            for annotation in annotations {
                guard let kickboardAnnotation = annotation as? KickboardAnnotation,
                      kickboardAnnotation.kickboard.nickName == kickboard.nickName else {
                    continue
                }
                removeAnnotation(annotation)
                break
            }
        }
        // 킥보드 이용 종료
        else if kickboard.endTime != nil {
            // 모달 제거
            rentKickboardModalView.removeFromSuperview()
            let annotation = KickboardAnnotation(kickboard: kickboard)
            addAnnotation(annotation)
        }
    }
}
