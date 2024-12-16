//
//  MapView.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import MapKit

class MapView: MKMapView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
