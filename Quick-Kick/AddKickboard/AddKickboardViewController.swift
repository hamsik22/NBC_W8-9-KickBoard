//
//  AddKickboardViewController.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import UIKit

class AddKickboardViewController: UIViewController, ModalViewDelegate {
    
    private let addressRepository: AddressRepository = .init()
    
    private lazy var containerView: AddKickboardView = .init()
    
    override func loadView() {
        view = containerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.setDelegate(self, addressRepository)
        containerView.modalViewDelegate = self
    }
}

extension AddKickboardViewController: MapViewDelegate {
    func requestNaverAddress(lat: String, lon: String) {
        addressRepository.fetchAddress(lat: lat, lon: lon)
    }
}
