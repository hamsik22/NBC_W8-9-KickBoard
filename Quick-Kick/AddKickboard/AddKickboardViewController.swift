//
//  AddKickboardViewController.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import UIKit

class AddKickboardViewController: UIViewController {
    
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

extension AddKickboardViewController: MapViewDelegate, ModalViewDelegate {
    func editKickboardModalView() {
        let modalVC = RegistrationModalViewController()
        modalVC.editKickboardData(false, "Sparta의 킥보드") // 추후 코어데이터에서 데이터를 받아와서 입력
        
        modalVC.modalPresentationStyle = .formSheet
        modalVC.sheetPresentationController?.preferredCornerRadius = 50
        modalVC.sheetPresentationController?.detents = [.medium()]
        
        self.present(modalVC, animated: true)
    }
    
    func requestNaverAddress(lat: String, lon: String) {
        addressRepository.fetchAddress(lat: lat, lon: lon)
    }
}
