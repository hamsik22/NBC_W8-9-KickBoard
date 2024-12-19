//
//  KickboardAnnotation.swift
//  Quick-Kick
//
//  Created by 이명지 on 12/18/24.
//
import UIKit
import MapKit

final class KickboardAnnotation: MKPointAnnotation {
    var kickboard: Kickboard
    
    init(kickboard: Kickboard) {
        self.kickboard = kickboard
        super.init()
        self.coordinate = CLLocationCoordinate2D(
            latitude: kickboard.latitude,
            longitude: kickboard.longitude
        )
    }
}
