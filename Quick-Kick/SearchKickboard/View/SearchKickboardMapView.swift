//
//  SearchKickboardMapView.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/16/24.
//
import UIKit
import MapKit

final class SearchKickboardMapView: MKMapView {
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .hybrid
        map.showsUserLocation = true
        return map
    }()
}
