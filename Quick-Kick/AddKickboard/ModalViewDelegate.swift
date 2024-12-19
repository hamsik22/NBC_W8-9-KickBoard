//
//  ModalViewDelegate.swift
//  Quick-Kick
//
//  Created by 장상경 on 12/17/24.
//

import UIKit
import CoreData

protocol ModalViewDelegate: AnyObject where Self: UIViewController {
    
    func presentModalView(_ latitude: Double, _ longitude: Double, address: String)

    func editKickboardModalView(_ isSaddled: Bool, _ nickName: String, _ id: NSManagedObjectID)

}

extension ModalViewDelegate {   
    func presentModalView(_ latitude: Double, _ longitude: Double, address: String) {
        let modalVC = RegistrationModalViewController()
        modalVC.setAddressInfo(latitude, longitude, address)
        modalVC.modalPresentationStyle = .formSheet
        modalVC.sheetPresentationController?.preferredCornerRadius = 50
        modalVC.sheetPresentationController?.detents = [.medium()]
        
        self.present(modalVC, animated: true)
    }
    
    func editKickboardModalView(_ isSaddled: Bool, _ nickName: String, _ id: NSManagedObjectID) {
        let modalVC = RegistrationModalViewController()
        modalVC.editKickboardData(isSaddled, nickName, id)
        
        modalVC.modalPresentationStyle = .formSheet
        modalVC.sheetPresentationController?.preferredCornerRadius = 50
        modalVC.sheetPresentationController?.detents = [.medium()]
        
        self.present(modalVC, animated: true)
    }
}
