//
//  ModalViewDelegate.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/17/24.
//

import UIKit

protocol ModalViewDelegate: AnyObject, UIViewController {
        
    func presentModalVIew()
    
}

extension ModalViewDelegate {
    
    func presentModalVIew() {
        let modalVC = RegistrationModalViewController()
        modalVC.modalPresentationStyle = .formSheet
        modalVC.sheetPresentationController?.preferredCornerRadius = 50
        modalVC.sheetPresentationController?.detents = [.medium()]
        
        self.present(modalVC, animated: true)
    }
}
