//
//  AddKickboardViewController.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import UIKit

class AddKickboardViewController: UIViewController {
    
    private let apiRepository: APIRepository = .init()
    
    private lazy var containerView: AddKickboardView = .init()
    
    override func loadView() {
        view = containerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.setDelegate(self, apiRepository)
    }
}

extension AddKickboardViewController: MapViewDelegate {
    func requestNaverAddress(lat: String, lon: String) {
        apiRepository.fetchAddress(lat: lat, lon: lon)
    }
}
