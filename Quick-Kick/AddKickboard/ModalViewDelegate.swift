//
//  ModalViewDelegate.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/17/24.
//

import UIKit

protocol ModalViewDelegate: AnyObject where Self: UIViewController {
        
    func presentModalView(_ latitude: Double, _ longitude: Double, address: String)
    
    func editKickboardModalView()
    
    func editKickboardModalView()
    
}

extension ModalViewDelegate {
    
    func presentModalView(_ latitude: Double, _ longitude: Double, address: String) {
        let modalVC = RegistrationModalViewController()
        modalVC.modalPresentationStyle = .formSheet
        modalVC.sheetPresentationController?.preferredCornerRadius = 50
        modalVC.sheetPresentationController?.detents = [.medium()]
        
        self.present(modalVC, animated: true)
    }
    
    func editKickboardModalView() {
        let modalVC = RegistrationModalViewController()
        modalVC.editKickboardData(false, "Sparta의 킥보드") // 추후 코어데이터에서 데이터를 받아와서 입력
        
        modalVC.modalPresentationStyle = .formSheet
        modalVC.sheetPresentationController?.preferredCornerRadius = 50
        modalVC.sheetPresentationController?.detents = [.medium()]
        
        self.present(modalVC, animated: true)
    }
    
    func editKickboardModalView() {
        let modalVC = RegistrationModalViewController()
        modalVC.editKickboardData(false, "Sparta의 킥보드") // 추후 코어데이터에서 데이터를 받아와서 입력
        
        modalVC.modalPresentationStyle = .formSheet
        modalVC.sheetPresentationController?.preferredCornerRadius = 50
        modalVC.sheetPresentationController?.detents = [.medium()]
        
        self.present(modalVC, animated: true)
    }
}
